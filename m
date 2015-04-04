From: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: Re: git clean performance issues
Date: Sat, 4 Apr 2015 22:39:47 +0200
Message-ID: <CAMpP7NZ8OD5or8H11OvuH1nq+qe-btKCsQnhas6+7SRYE1M1Tw@mail.gmail.com>
References: <CAMpP7NY++BwV+UygRj1C6Zsf=jE-z1AQuN3On0HeEqQpKGQtqw@mail.gmail.com>
	<20150404195507.GA31763@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 04 22:39:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeUrA-0007gU-Eg
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 22:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbbDDUjs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Apr 2015 16:39:48 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:35616 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbbDDUjr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Apr 2015 16:39:47 -0400
Received: by obbfy7 with SMTP id fy7so1723305obb.2
        for <git@vger.kernel.org>; Sat, 04 Apr 2015 13:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=T3EsScv4CHzDVIpPoUw2UN4Ocv5Xg1nzLMVRQ+GLmvU=;
        b=oBRAe1htIyA3YTl5oVU5+dYkOw1C0SOsJKMT+JsLDczvJj3VJ6UvuwQnpnJghPllSs
         NawHWGhfFpCdlrB83os+jQAMPq5XCwNNo/HhYSlhUIgo0YoRltNpQsbIJrAIjaRrnPFH
         OZNIeeRIBaN5jkPo+CUlqyqKHNJ0QH3RujQWWtbl+VhCtnpLI8A+NWdYjB0O1wlK3lDO
         j+TtASeLOC8bOz+CxCXxuEBwhEVjLLsn5h3K7wNQgmwmYE0VEzLswGzxw5JZrM/aTKMT
         Ho9SUtYcnHNIzfZQWO705fwgjkJq4lV2qLks+gJkmu1xGPTkX3cJjZ9dgC65sZbv6/mj
         sTYg==
X-Received: by 10.60.45.165 with SMTP id o5mr10185727oem.44.1428179987078;
 Sat, 04 Apr 2015 13:39:47 -0700 (PDT)
Received: by 10.182.154.72 with HTTP; Sat, 4 Apr 2015 13:39:47 -0700 (PDT)
In-Reply-To: <20150404195507.GA31763@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266786>

That looks like the same issue. The "use is_git_directory" approach
sounds good to me, is that the direction you would prefer? I can try
to cobble something together although I must warn you I have zero
previous experience with this code base so a few iterations will
probably be needed.

/Erik

On Sat, Apr 4, 2015 at 9:55 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Apr 04, 2015 at 08:32:45PM +0200, erik elfstr=C3=B6m wrote:
>
>> In my scenario get_ref_cache will be called 10000+ times, each time
>> with a new path. The final few calls will need to search through and
>> compare 10000+ entries before realizing that there is no existing
>> entry. This quickly ads up to 100 million+ calls to strcmp().
>>
>> From what I can understand, the calls to get_ref_cache in this
>> scenario will never do any useful work. Is this correct? If so, woul=
d
>> it be possible to bypass it, maybe by calling
>> resolve_gitlink_ref_recursive directly or by using some other way of
>> checking for the presence of a git repo in clean.c:remove_dirs?
>
> I think this is the same issue that was discussed here:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/265560/focus=
=3D265585
>
> There is some discussion of a possible fix in that thread. I was hopi=
ng
> that Andreas was going to look further and produce a patch, but I
> imagine he got busy with other things. Do you want to try picking it =
up?
>
> -Peff

From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: Use of a mailmap file with git-log
Date: Mon, 10 Dec 2012 20:47:21 +0100
Message-ID: <CALWbr2ydMkR_O-Gev7k-HjGadRJMv0UH3XdqtM0Jt=vC82GwJw@mail.gmail.com>
References: <CALKB1SXdNVsQop5VYmShOMx93+j5SPdkGF9yNU5k7nXg87TwMw@mail.gmail.com>
	<7v38zdbv6d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Rich Midwinter <rich.midwinter@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 20:48:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ti9KX-0001Fn-M1
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 20:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543Ab2LJTrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2012 14:47:24 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:48658 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274Ab2LJTrW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2012 14:47:22 -0500
Received: by mail-qa0-f46.google.com with SMTP id r4so1995023qaq.19
        for <git@vger.kernel.org>; Mon, 10 Dec 2012 11:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UD3LlcQykDntJF13/5wC7+OMO/tHoKUKaePwwQpdKyo=;
        b=THu+sNmgxyOzKQKmSHDoZfCyr1FBEY/bckPiKA03DwNRsobILYGhcO/DFZ0/qRuHH5
         1wUavlOsD80OGnyZbiMnpWgXboKuoyAXpiPHKPXplqejoOJvFon9Th0j7zZcrOJpXgtg
         vBAsV7DMvhdg1e9dQAkQKsSh/KQM9SkHEHGzkoQoA+iGQizFNMgYf/K6BQQphhx9/glt
         HjaY7wxL8zmZFfIAwx5ustv7YU9jx2eBcS6uOZJGXmMm8Rakvk50IqnAMbuyMcLrFO3p
         dqVkGB/xcA5v4NjVxL2odbwyyxJAErWCTfumPht3oYtmN5WGXIYmqAJcaUn63rpOyzh3
         gWGQ==
Received: by 10.224.201.73 with SMTP id ez9mr28940792qab.92.1355168841841;
 Mon, 10 Dec 2012 11:47:21 -0800 (PST)
Received: by 10.49.36.130 with HTTP; Mon, 10 Dec 2012 11:47:21 -0800 (PST)
In-Reply-To: <7v38zdbv6d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211271>

Hi,

I was thinking about that last week.
It could indeed be very interesting to have mailmap applied to git-log and
especially to git-log --author/--committer.

My first look at the code let me think that we would need to change the
parse_commit_buffer to replace, at reading time, the name of author and
committer if an option (--use-mailmap seems like a wise choice) and
probably a config option.
The choice of parse_commit_buffer to do the modification is due to
the grepping being done directly on buffer when grepping author/committerer.

Yet I'm afraid it could be:
1. expensive to rewrite all commit log (reallocating the buffer)
2. Inappropriate to change the value in function that is supposed to
read

My 2 cents.

Cheers,

On Mon, Dec 10, 2012 at 7:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Rich Midwinter <rich.midwinter@gmail.com> writes:
>
>> I'm working on a project for a large organisation that wants to make
>> widespread use of git and the mailmap feature.
>>
>> This seems to be supported by default in git-shortlog but not git-log
>> (and other variants) without specifying custom formats, which isn't
>> really something I want to try and 'fix' across the organisation. Is
>> there a reason for this feature omission or has it just evolved that
>> way and could it be fixed?
>
> I think it was pretty much the latter, but people may already be
> depending on the command to give them the "true as recorded back
> then" names in the output.  A fix may have to involve inventing a
> new option "log --use-mailmap" that is explicitly given from the
> command line.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

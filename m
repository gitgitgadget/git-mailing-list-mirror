From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: ephemeral-branches instead of detached-head?
Date: Wed, 14 Aug 2013 05:34:56 +0530
Message-ID: <520AC9A8.4030104@gmail.com>
References: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com> <7veh9z1gym.fsf@alter.siamese.dyndns.org> <CA+CP9O5fhyQrn3SboafocWJjaAywJHC0T-bw+AXk_8RX53hJ6Q@mail.gmail.com> <CACsJy8Dke6Pezqsdcjzejc_cWCgOGTGs8LifjM2h2TQJy7N4HA@mail.gmail.com> <7vk3jpy1qt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, David Jeske <davidj@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 02:05:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9OaN-00035S-8M
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 02:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758330Ab3HNAFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 20:05:05 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:40347 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758101Ab3HNAFD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 20:05:03 -0400
Received: by mail-pb0-f53.google.com with SMTP id up15so8586212pbc.12
        for <git@vger.kernel.org>; Tue, 13 Aug 2013 17:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=FzMb6w0XQuiLRetWH2BDNZNLxGeUWdScGMcHotd8Ijw=;
        b=WlJF1ARewEoNWRR315Q3VE+CjsEAUw2PiG/Bs5tBhGngbsFqKvVotWbh7/WzqWlEIx
         FOsCyerBKOrclsfZPrfwVMMYAZCe2//NcBShYJRXIdJoMoJgf9Zp4Lak7pJsQQ6VXZFI
         wwgexbKrQoTB8AsWhyKIXlPVbe9ME1B9aua+ridy81zNgHaTvib/xlSsnSI4FZKpaAkv
         hE8xvX3NEjwnsbrTMvuMZpXc9NOgWhP0+AX/s+J31Ych07aYagIiwjgTWmRqFLQjjwlf
         pxAHCLo+yFB7HoiAvhQuq27bh7zzGdULkxAhM9Y//bL/liizmrNj/5LX47fZM/2RP3th
         cMUg==
X-Received: by 10.66.121.131 with SMTP id lk3mr7017299pab.43.1376438701411;
        Tue, 13 Aug 2013 17:05:01 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.216.209.211])
        by mx.google.com with ESMTPSA id ef10sm49501009pac.1.2013.08.13.17.04.58
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 13 Aug 2013 17:05:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130805 Thunderbird/17.0.8
In-Reply-To: <7vk3jpy1qt.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232255>

On 08/13/2013 10:19 PM, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
>> On Mon, Aug 12, 2013 at 3:37 PM, David Jeske <davidj@gmail.com> wrote:
>>> Is there currently any way to say "hey, git, show me what commits are
>>> dangling that might be lost in the reflog?"
>>
>> How do you define dangling commits? When you do "git commit --amend",
>> the current commit will become dangling (in the sense that it's not
>> referred by any ref, but the commit exists) and those are just noise
>> in my opinion.
> 
> "fsck lost-and-found" would be one way.  It would be nice if we had
> something like (note: the following will _NOT_ work)
> 
> 	git log -g HEAD --not --branches
> 
> to say "walk the reflog of HEAD, but exclude anything that can be
> reached from the tips of branches".

I've been using the following 3 aliases for some time now, to find
various dangling stuff.  The middle one (d1) seems to do approximately
what you want, but will probably fail on repos with lots of activity
when the command line length limit is (b)reached.

    # all stashed entries (since they don't chain)
    sk = !gitk --date-order $(git stash list | cut -d: -f1) --not --branches --tags --remotes
    # all reflog entries that are not on a branch, tag, or remote
    d1 = !gitk --date-order $(git log -g --pretty=%H) --not --branches --tags --remotes
    # all dangling commits not on a branch, tag, or remote
    d2 = !gitk --date-order $(git fsck | grep "dangling.commit" | cut -f3 -d' ') --not --branches --tags --remotes

(Apologies if something like this was already said; I was not following
the discussion closely enough to notice)

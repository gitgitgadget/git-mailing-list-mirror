From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] git-svn: forward -q to git-rebase
Date: Tue, 12 Jun 2012 22:41:53 +0200
Message-ID: <CABPQNSbJFzOEVSohbrY6GMVsmNFRzrxyTm-MoNr5RJ+2hUBzNQ@mail.gmail.com>
References: <1339515815-10752-1-git-send-email-kusmabite@gmail.com>
 <7vd354jwss.fsf@alter.siamese.dyndns.org> <CABPQNSYxq1cSYKi+fGajoASL6x7e6VCaSDoWNmYuEHSgt8NFBA@mail.gmail.com>
 <CABPQNSZN7zzF4rki38x3PHXT2DZhOjUtUVGNx2mY-wnQtCj-pA@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, normalperson@yhbt.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 22:42:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeXvJ-0007Wl-Dg
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 22:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194Ab2FLUmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 16:42:35 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35639 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186Ab2FLUme (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 16:42:34 -0400
Received: by pbbrp8 with SMTP id rp8so1312543pbb.19
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 13:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fB7/69KniymQngfF/GV5C8xrutepYWRTvW3Kuop8jDE=;
        b=cH6UKv/cNcTOk5YQ1o0ndZ0IZGJFo48WE+3tgiPpJJkCFUWrM7U0c7J6UsXxSaB79n
         qIh4aP3u9WB8+gnwsSZShtokd+Dn6mFVmWj2iDXsFRy4i1H586C13BVjrgJZJH0HnGTP
         D8h8dxCAtdNb4B46SMHF8hffe7CfiZOEbDHVMC6ja3uio2b+z3FcH5/C424m0hINMjpg
         45xsiSdqqsPlnSc8hoFYCjdfwiSjFWelXQHUQzCcRZ1q3ClNKm4h6+/Se8Q18BeycXDD
         E8oNUD8X0F9vJ9DVBkyyrLA2iZOPGAivd+D5o6ZIiiAAtShUFIBBpkn3nFf9jwWUxXU5
         Gc6Q==
Received: by 10.68.226.97 with SMTP id rr1mr3124088pbc.64.1339533753466; Tue,
 12 Jun 2012 13:42:33 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Tue, 12 Jun 2012 13:41:53 -0700 (PDT)
In-Reply-To: <CABPQNSZN7zzF4rki38x3PHXT2DZhOjUtUVGNx2mY-wnQtCj-pA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199852>

On Tue, Jun 12, 2012 at 10:39 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Tue, Jun 12, 2012 at 10:23 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> On Tue, Jun 12, 2012 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>>
>>>> When calling "git svn rebase -q", we still get the message
>>>> "Current branch BRANCHNAME is up to date." from git-rebase, which
>>>> isn't quite as quiet as we could be.
>>>>
>>>> Fix this by forwarding the -q flag to git-rebase.
>>>>
>>>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>>>> ---
>>>>
>>>> I just set up a cronjob that did a "git svn rebase -q", and noticed
>>>> it triggered cron to send me an e-mail every time.
>>>>
>>>> Since I'm not really interested in getting an e-mail every time the
>>>> script does nothing, but I'd like the option to get an e-mail whenever
>>>> it does something useful, perhaps something like this can benefit
>>>> other people as well?
>>>
>>> If it matches what you would get from "git pull -q" run in a
>>> cronjob, I would say that is a sensible change to make.
>>
>> Seems like it to me in my tests, yeah.
>
> Hm, but not the same as "git pull --rebase -q", as git-pull.sh doesn't
> forward $verbosity to "git rebase" either.

The obvious fix to that (if we decide it needs fixing, that is), is this:

diff --git a/git-pull.sh b/git-pull.sh
index 2a10047..2920c69 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -278,7 +278,7 @@ fi
 merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 case "$rebase" in
 true)
-	eval="git-rebase $diffstat $strategy_args $merge_args"
+	eval="git-rebase $diffstat $strategy_args $merge_args $verbosity"
 	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
 	;;
 *)

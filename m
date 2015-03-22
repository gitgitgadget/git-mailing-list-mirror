From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/RFC/GSOC] make git-pull a builtin
Date: Mon, 23 Mar 2015 01:39:48 +0800
Message-ID: <CACRoPnT04p-6o2u984a21RvHkk6CqpZWRyafg=T+WAPOD3hiTg@mail.gmail.com>
References: <1426600662-32276-1-git-send-email-pyokagan@gmail.com>
	<vpqwq2eyyzl.fsf@anie.imag.fr>
	<CACRoPnQp-3RGAPmoo1aM2KUA-phi138J2o82FwP9annM+xvOXA@mail.gmail.com>
	<4388b6e4005c2872aa7f5f83024f021d@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 22 18:40:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZjqt-0005hq-Rz
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 18:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbbCVRjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 13:39:51 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:32869 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbbCVRju convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2015 13:39:50 -0400
Received: by lbbrr9 with SMTP id rr9so40239238lbb.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 10:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=6D1hdq7Qr3/DeDfu0UaiqvUCCXmeGBDM5xG9yqJpqsA=;
        b=rNARwDNMwhgMv17q0YOlz90vgyng6RBjaRJPxRsCWl02Kj7YAKIVyvyg7Bp4d5PB0q
         UHtPS9zXcnd79HGE77wxlrfnPx7F71zd5Z38XCzvagjr59/vVLtExyhLLYlOs30qlmX9
         6c+Feraqe+d+R+dmLA8ZEHQHdxtAH6pNd1ob/rbE0IYmomHzG0cNc2fkEmx9kaUc3wV1
         iyRAyNso1NcURvO/MxKk6pwB0mv/Hx4/CgsyNQX2OVXkDYDkqyka2m+jhmJt1yJejF4c
         r9TKVE0q7CP9qOmp2tt9MNFMI5al9wJDvbKS4Hmbgvx4R55+ZEncEGmY2kRHBtgQuI+9
         zF1w==
X-Received: by 10.112.44.132 with SMTP id e4mr80558494lbm.66.1427045988636;
 Sun, 22 Mar 2015 10:39:48 -0700 (PDT)
Received: by 10.112.130.228 with HTTP; Sun, 22 Mar 2015 10:39:48 -0700 (PDT)
In-Reply-To: <4388b6e4005c2872aa7f5f83024f021d@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266073>

Hi,

On Sun, Mar 22, 2015 at 1:35 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
>> Maybe code coverage tools could help here so we only need to focus on
>> the code paths that are untested by the test suite. At the minimum,
>> all of the non-trivial code paths in both the shell script and the
>> converted builtin must be covered by tests. This should help to
>> eliminate most sources of breakages. Anything further than that would
>> require an experienced understanding of all the possible important
>> inputs to be tested, which I personally feel would make the project
>> quite tedious.
>>
>> I see git already has gcov support. For shell scripts, maybe kcov[1]
>> could be used. With some slight code changes, I managed to generate a
>> report for the git-pull tests[2] which should at least provide a good
>> starting point for how the tests can be improved.
>
> While it is often a tempting idea to make test suites as thorough as possible, there lies a true danger herein. True war story: in one of the projects I was involved in, the test suite grew to a size that one complete run lasted two weeks. Yes, that is fourteen days. Needless to say: this test suite was run rarely. How useful is a test suite that is run rarely? More useful than a non-existent one, to be sure, but it is still more of a burden than a boon.
>
> Now, on Windows the test suite takes almost three hours to run. This really, really slows down development.
>
> So while we are not yet at the "too large to be useful state", I would caution against trying to get there.
>
> Instead, I would really like to focus on the *usage*. Calling `git grep "git pull" t/` should give you an idea what usage of `git pull` is already tested. It should be pretty easy to come up with a list of *common* use cases, and if any of them are not covered, adding tests for them is simple and straight-forward, too.

The code coverage tools can help here as well. The kcov output clearly
shows which options of git-pull are currently not being tested. But
yes, I agree that the test suite shouldn't be relied too much on
compared to code inspection and review.

On another important topic, though, along with git-pull.sh, I'm
looking for another script to convert in parallel with git-pull.sh so
that there will be no blocks due to patch review. Generally, I think
rewriting scripts that are called frequently by users, or spawn a lot
of processes due to loops, would be most desirable because the runtime
gains would be much higher. A quick review of the scripts shows that
git-am.sh, git-rebase--interactive.sh and git-quiltimport.sh have
pretty heavy loops with lots of process spawning that grows with
input.

I'm currently leaning with git-am because not only is it a frequently
used command, git-rebase--am.sh (for non-interactive rebase) calls it
as well. In fact, quick tests show that it takes up 98% of
git-rebase's execution time on Windows, so if git-am's performance
improves it would be a huge win on many fronts. git-am's code also
seems to be manageable for a 3-month project.

Anyway, I would like to know if you (or anyone else) have any scripts in mind.

(I also think that just 2 scripts would be enough to fill the 3
months, but that might be me just being too conservative)

Regards,
Paul

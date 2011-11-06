From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Sun, 6 Nov 2011 20:38:08 +0100
Message-ID: <CAGdFq_hmF8xDA8PdDUPygSSAVsvrA=BRVKp+eCVRggHxLZzBsQ@mail.gmail.com>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
 <1320535407-4933-2-git-send-email-srabbelier@gmail.com> <20111106043157.GM27272@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 20:38:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN8YQ-0002Wt-T9
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 20:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360Ab1KFTiu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 14:38:50 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51315 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182Ab1KFTit convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2011 14:38:49 -0500
Received: by gyc15 with SMTP id 15so3387098gyc.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 11:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=wVswf7N3ezfXVwWPiMXjaPWzOtbvhk/qMMA0Wd5RNVM=;
        b=EW2t30dUqae63hqmVPXwSFWbpiRnXxH3PMp0WWhh7W8Gj0HZmKvreBekd6CHJt1yqU
         9iKpzIIuhWaNhqmjRZjIJlGdS0kpTlQMtbFpiICUuTK3hQ5XOdETxoL62lPEjqbltc5k
         9Ew/kfHzHks/93cjzq2V6X358jKnUaDQxF0kQ=
Received: by 10.182.147.4 with SMTP id tg4mr6362970obb.60.1320608329081; Sun,
 06 Nov 2011 11:38:49 -0800 (PST)
Received: by 10.182.52.3 with HTTP; Sun, 6 Nov 2011 11:38:08 -0800 (PST)
In-Reply-To: <20111106043157.GM27272@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184926>

Heya,

On Sun, Nov 6, 2011 at 05:31, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
>> This happens only when the corresponding commits are not exported in
>> the current fast-export run. This can happen either when the relevan=
t
>> commit is already marked, or when the commit is explicitly marked
>> as UNINTERESTING with a negative ref by another argument.
>
> The above "This" has no antecedent. =C2=A0I guess you mean that
> fast-export writes no output when passed a range of the form A..A.

Well, it's referring to the subject, how about:

"When a commit has not been exported in the current fast-export run
its ref is not updated correctly. This can happen ...".

>> as they use marks
>> files to store which commits have already been seen. The call graph
>> is something as follows:
>>
>> $ # push master to remote repo
>> $ git fast-export --{im,ex}port-marks=3Dmarksfile master
>> $ # make a commit on master and push it to remote
>> $ git fast-export --{im,ex}port-marks=3Dmarksfile master
>> $ # run `git branch foo` and push it to remote
>> $ git fast-export --{im,ex}port-marks=3Dmarksfile foo
>>
>> When fast-export imports the marksfile and sees that all commits in
>> foo are marked as UNINTERESTING
>
> Hmm, I didn't know about this behavior. =C2=A0Would it be possible to=
 add
> a test for it, too?

What behavior are you referring to here? What kind of test would you wa=
nt added?

>> =C2=A0t/t9350-fast-export.sh | =C2=A0 11 +++++++++++
>> =C2=A01 files changed, 11 insertions(+), 0 deletions(-)
>
> With or without the change suggested above, this new test seems to me
> like a good thing, even though in the longer term it might be nicer t=
o
> teach fast-export to understand a syntax like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git fast-import ^master master:master
>
> Put another way, the possibility of something nicer later shouldn't
> stop us from adding an incremental refinement that improves things
> today.

Yes, extending the capabilities of fast-export is needed if we want
the remote-helpers to be as powerful as native git.

--=20
Cheers,

Sverre Rabbelier

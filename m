From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 7/8] checkout: prefix --to argument properly when cwd
 is moved
Date: Wed, 30 Jul 2014 17:32:57 +0700
Message-ID: <CACsJy8DmufHRy_LcmPmLozGRNGa8pYSprdhWM5qq8xydPuw=UQ@mail.gmail.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
 <1406641831-2390-1-git-send-email-pclouds@gmail.com> <1406641831-2390-8-git-send-email-pclouds@gmail.com>
 <xmqq8unb3n3m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 12:33:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCRCP-0001r0-Gs
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 12:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbaG3Kd3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jul 2014 06:33:29 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:40689 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbaG3Kd2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jul 2014 06:33:28 -0400
Received: by mail-ig0-f172.google.com with SMTP id h15so7049801igd.17
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 03:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=84GstspbJ8e93MGMQmUXLXHfM06agk2Y+1essqe/AEg=;
        b=RBReyPdz9KjUN55Aa630AHQ1YOyOB2vfaH0gfc4k8S0rVsSM4wqaMcQHSE/OSUa1mr
         OH8Bt1txstMWRVIBvvOYm+GZJcGTdyy8kXguw9uq1WV74XgdeGu7pnugGlQiSXlX6gPl
         E0k/zDICuOrahz/IamhiMC61GOAXq2uAOCDrCqjhF3sv7/i7vpXRg0OLGfhXHwM1/tZC
         JOC/TMKaZnXot7xmJxEtTYOPET+ZlmbSIvr2K5Rx7YPOekcQ07jfl11BuSyA8cIbtTm5
         PvfMIPPF0ZiIaVqk8N6U22T4JkRY6KI1UsB8Y/Zjowjj/T04V78nvoppmyuF7kXVwmOL
         zwew==
X-Received: by 10.42.65.3 with SMTP id j3mr4282763ici.65.1406716407767; Wed,
 30 Jul 2014 03:33:27 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Wed, 30 Jul 2014 03:32:57 -0700 (PDT)
In-Reply-To: <xmqq8unb3n3m.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254484>

On Wed, Jul 30, 2014 at 3:51 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  builtin/checkout.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> index 173aab1..4fbb9c1 100644
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -1342,7 +1342,7 @@ int cmd_checkout(int argc, const char **argv, =
const char *prefix)
>>                        N_("do not limit pathspecs to sparse entries =
only")),
>>               OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
>>                               N_("second guess 'git checkout no-such=
-branch'")),
>> -             OPT_STRING(0, "to", &opts.new_worktree, N_("path"),
>> +             OPT_FILENAME(0, "to", &opts.new_worktree,
>>                          N_("check a branch out in a separate workin=
g directory")),
>>               OPT_END(),
>>       };
>
> Good thinking.  Otherwise this would not work from within a
> subdirectory.  Perhaps you would want a test for it?

Will do at the next round.

> An unrelated tangent, but would we want to further enhance
> OPT_FILENAME() to understand ~/path and ~user/path perhaps?
> It is easy to rely on users' shells to do so, so it is not a big
> deal and it certainly is unrelated to this particular topic.

Yeah, the only user group that probably wants this is cmd.exe users.
We already have expand_user_path for this, all needed is some glue.
I'll let Windows users do this if they really want to.
--=20
Duy

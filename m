From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Can't get git rebase --onto to work
Date: Thu, 2 Jun 2011 11:43:19 +0100
Message-ID: <BANLkTin92KXYO3YF1UytcesWUV-Nh_LaGg@mail.gmail.com>
References: <BANLkTikF7p_XsU6YJ81bq10S3nL6tBsApg@mail.gmail.com>
	<20110602103833.GA4709@Imperial-SSD-Overlord>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tim Guirgies <lt.infiltrator@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 12:43:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS5N7-0006Mk-Cr
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 12:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933441Ab1FBKnU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2011 06:43:20 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:64884 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932803Ab1FBKnT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2011 06:43:19 -0400
Received: by yia27 with SMTP id 27so275733yia.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 03:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vIZV31PE1W6PJeRO1YSp6t6MoqE2F3c6NqbOSYAGTE0=;
        b=wHUvex5WayCLoGSBFpsAr3msW488h4PATcuFeBdpRV11kKpFwPLnnb17PFklLc51gG
         L7tbxAxgH30gO8wez5VRsM4w3a8mCgfbiOaR75QD8NhhnPgZfXYaxbmNtBlbOYzDycrd
         7CWFIf4AC38+/eM9aEvsLA5FADGrlEVCdBWPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=AO+p3VF2Wsya2yeR7MzNt7OPyRq4RnzfjWp/Se774/LIcBPaftLn049CnQSbWoRWcu
         tM3kEYxQb3WoiDFIoybxHVKdCGkYhPHExqdG3Ct+hwhM12dMz85HHCZukFaIeWHgWhjN
         2XCR+0nlZSLyNXKyDWj+x7I2ioSQ4AggaVilQ=
Received: by 10.91.87.15 with SMTP id p15mr502472agl.192.1307011399210; Thu,
 02 Jun 2011 03:43:19 -0700 (PDT)
Received: by 10.90.116.15 with HTTP; Thu, 2 Jun 2011 03:43:19 -0700 (PDT)
In-Reply-To: <20110602103833.GA4709@Imperial-SSD-Overlord>
X-Google-Sender-Auth: WDslGfPu-beHmdvz87qQVHybrMA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174939>

On 2 June 2011 11:38, Tim Guirgies <lt.infiltrator@gmail.com> wrote:
> On Thu, Jun 02, 2011 at 11:17:41AM +0100, Howard Miller wrote:
>> Trying to explain this as concisely as possible.
>>
>> I started with the following branches (names changed to protect the =
guilty)...
>>
>> * clientA
>> * clientB
>>
>> both have a common ancestry....
>>
>> I then checked out clientB created a new branch clientB_patch and di=
d
>> a load of work and commits.
>>
>> However, I actually wanted all those commits to apply to clientA
>> branch instead so....
>>
>> git checkout clientA
>> git checkout -b clientA_patch =A0 =A0 (to ensure I didn't wreck orig=
inal branch)
>> git rebase --onto clientA_patch clientB clientB_patch
>>
>> It says "rewinding" head and then applies the commits I would have e=
xpected.
>>
>> However, I have now been switched to the 'clientB_patch' branch and =
it
>> says that it differs from its tracked remote branch by hundreds of
>> commits.
>>
>> clientA_patch is unchanged. It seems to have mangled clientB_patch a=
nd
>> done nothing to clientA_patch. Where did I go wrong?
>
> "--onto clientA_patch"
>
> Please read that out loud. =A0It's meaning in git is the same as in
> English. =A0What you did was rebase clientB_patch _onto_ clientA_patc=
h.
> For more information, see "git help rebase".
>
> What you should have done instead:
>
> git checkout -b clientA_patch clientB_patch
> git rebase -i clientA
>
> What that does is create and then checkout a branch called clientA_pa=
tch
> at the same commit as clientB_patch, then rebase your currently check=
ed
> out branch (clientA_patch) on top of clientA; the "-i" option allows =
you
> double check what's being rebased, as otherwise it would take a whole
> lot clientB history with it. =A0Simply delete the lines with the comm=
its
> you don't want.
>
>
> To fix what you currently have, though, you must do the following. =A0=
Take
> heed, however, as I making assumptions that the situation is unchange=
d
> from what you described above.
>
> git checkout clientB_patch
> git reset --hard origin/clientB_patch
>
> I'm assuming your remote is called origin, and also that whatever you
> pushed last is the latest. =A0If not, you'll have to look at "git ref=
log"
> to see which commit to reset the branch to.
>
> Now do:
>
> git checkout clientA_patch
> git reset --hard clientB_patch
> git rebase -i clientA
>
> That should give you what you want.
>
> Good luck.
>
>

Hi Tim,

Thanks for the lengthy post :) As I said in my previous post, I
think/hope I have resolved it. I did read the manpage first (I'm not
so brave not to before posting here!!) and it did what it said it
would. I just misinterpreted it. A final merge was required. I
actually picked that up from the "Pro Git" book page which mentions
that extra step.

From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Refactoring git-rebase.sh and git-rebase--interactive.sh
Date: Fri, 5 Nov 2010 09:58:17 +0100
Message-ID: <AANLkTi=tQFN-LckpMyKj=NN9ZSmb=DWC=ztLE_e666Xj@mail.gmail.com>
References: <AANLkTimeWDbJPor9PnKgW5sD7DLjqrm-vTzEtnARvP3M@mail.gmail.com>
	<201011030424.33093.chriscool@tuxfamily.org>
	<20101104211556.GB8911@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Fri Nov 05 09:58:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEI7t-0006v5-JC
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 09:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584Ab0KEI6V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Nov 2010 04:58:21 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60795 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527Ab0KEI6S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Nov 2010 04:58:18 -0400
Received: by wyb36 with SMTP id 36so843533wyb.19
        for <git@vger.kernel.org>; Fri, 05 Nov 2010 01:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AjJCSqjVM/K4/kVhcNx4OSTWcY/aRKSOAvg7n5wtqSk=;
        b=mPYpxp22Z4+1L9dF24vhJT2E1FtPOKCv8FGzFLyRLfSNIaTGePgY67mA64TJEhIrh/
         J5N9YH7jYda2R4N9uya71kaZ8s5bvvOrbiGLmOZ3ELi8HKZN05SZF+Vdd+hVBMusGdas
         QNLWqwreHI+bO0zQKdRXU6yT687Xv3bwgn40A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XDq+dlwkEtK9gUU54/ZhgscYDrYgcCYIgjDBSh7IhnstjLV+ekutNLLToP1Fv1607z
         vT13RtDjk5K7u7FFc1B+rRHkm4/gOetvMoHIMwk6krKJbMtmbSmVEQ882oblu4vQKRYt
         4VhehjH+NBBWxPwbJx5zaeUztHNQSu+bnA+0g=
Received: by 10.216.26.138 with SMTP id c10mr896338wea.23.1288947497375; Fri,
 05 Nov 2010 01:58:17 -0700 (PDT)
Received: by 10.216.26.208 with HTTP; Fri, 5 Nov 2010 01:58:17 -0700 (PDT)
In-Reply-To: <20101104211556.GB8911@home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160809>

Hi Yann,

On Thu, Nov 4, 2010 at 10:15 PM, Yann Dirson <ydirson@free.fr> wrote:
> Hi Christian,
>
> On Wed, Nov 03, 2010 at 04:24:32AM +0100, Christian Couder wrote:
>> Now that GTAC (http://www.gtac.biz) is over, I plan to work on optio=
ns
>> --continue, --abort and --skip for git cherry-pick/revert. After tha=
t I hope
>> to be able to refactor the code so that in the end common code is us=
ed by
>> cherry-pick/revert and rebase.
>
> Sounds like "sequencer is coming back", great news :)

Yeah, but don't expect something soon because I am quite busy these day=
s.

> I don't know if you would like the idea enough, but something I often
> think would be good to have (and which could be useful for cherry-pic=
k
> and other commands in need of a sequencer), would be more flexibility=
=2E
> The thing I find myself lacking most often, is the possibility to
> change my mind on an already-edited commit (ie, go back after
> --continue), the alternatives I can see today being:
>
> - keeping a note on what to do on next pass (but may be more work in =
case
> =A0of conflicts with further commits)
> - fast-forward --continue'ing to keep curent changes and add new ones=
 in
> =A0next pass (same restriction)
> - --abort'ing the rebase and starting it again, possibly fetching the
> =A0changes from previous run via HEAD's reflog (not very handy either=
)
> - checkout back to where you want to re-amend and cherry-pick those y=
ou
> =A0already passed, essentially redoing an interactive rebase by hand
>
> If we could go back to previous commit, while keeping changes done to
> the current one (say, --previous), or reverting to the original one
> (say, --revert). =A0In the same way, continuing until another
> previously-unforeseen commit without the need to edit the todo file
> would be nice to have (eg. --next).
>
> While I'm at it, another somewhat loosely option I have thought of
> would be to seed the todo file with "edit" commands instead of "pick"=
,
> to make it possible to validate a series of patches one by one before
> sending. =A0That could be generalized for running a test script
> automatically, that is inserting "x whatever" between all pick's - an=
d
> my 1st idea would boil down to inserting arg-less "edit" or "x false"
> instead. =A0Maybe some --stepcmd=3D<command> flag ?

If you want them, feel free to work on those options without waiting
for a sequencer.

Thanks,
Christian.

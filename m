From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule 
	working directory in git gui and gitk
Date: Thu, 7 Jan 2010 00:23:35 +0700
Message-ID: <fcaeb9bf1001060923m6559f00bp794bb5fdd4af704c@mail.gmail.com>
References: <4B3F6742.6060402@web.de>
	 <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de>
	 <4B42F425.4010901@web.de> <7v1vi428w0.fsf@alter.siamese.dyndns.org>
	 <4B43292C.5060106@web.de> <7vd41oz9mp.fsf@alter.siamese.dyndns.org>
	 <4B439A86.3020500@web.de> <7vbph8oxg0.fsf@alter.siamese.dyndns.org>
	 <4B4498BC.5040400@web.de> <7vbph7181x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 18:23:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSZbi-000886-2X
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 18:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313Ab0AFRXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 12:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296Ab0AFRXi
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 12:23:38 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:40845 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932299Ab0AFRXh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 12:23:37 -0500
Received: by pwj9 with SMTP id 9so11334580pwj.21
        for <git@vger.kernel.org>; Wed, 06 Jan 2010 09:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=OtLf5YRB24A7mN0DS0+WnZP5n1eDndoz+gfWEl9efbo=;
        b=HbYEPw2U2txxKbsFNDFtFEEDRbvGInm0wuOf1EgakbDGEKbzYYbNrYEGA0qOJ+V+oH
         G+GzSGXLZeXIA1tXuksIDr6WufnxMC2aNacfKRWOV+NJbXxpINS4D3r46n/iZyK2sDH3
         frO41l3J2xwh6hAekCgysAzce18z2Vz2wwheU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=RI28Hw5rqMoTj5G3azAiHDO9pV972/851MDTjg+2k6hZIUuImRLWX2eyLMF7s7DSwm
         m2Gkm6Jv3K3IQJO+ulgk7FB+lkb5Pr9LegvXlT4vU1D5x2ElAfeo2GnDAR+LWw3y05e0
         ypXDB2HxfG9eQ+V5v9G4XQEgL8/5JZRAihXQA=
Received: by 10.114.86.7 with SMTP id j7mr2689027wab.209.1262798615676; Wed, 
	06 Jan 2010 09:23:35 -0800 (PST)
In-Reply-To: <7vbph7181x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136277>

On 1/7/10, Junio C Hamano <gitster@pobox.com> wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
>
> > Am 06.01.2010 02:04, schrieb Junio C Hamano:
>  >> After all we _were_ in agreement.  We both think the user should be told
>  >> about untracked files in submodule directory when inspecting the status to
>  >> make a commit in the superproject.
>  >
>  > Thanks. So i'll take a closer look at the diff core (but i suspect i'll
>  > need some time until i can come up with some patches because i don't know
>  > this part of git very well).
>
>
> I don't see a direct connection between "the user should be told about
>  untracked in the submodule before committing" and diffcore.  It is just
>  the matter of "git status" and "git commit" running another instance of
>  "git status" via run_command() interface in the submodule directory, no?

You would need to rewrite file paths so that files in submodules are
also relative to the same directory as files in supermodule (I tried
to do that with GIT_WORK_TREE and needed to change a bit). Or you
could show each "git status" output separately, which does not look as
nice as the former in my opinion.
-- 
Duy

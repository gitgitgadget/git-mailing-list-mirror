From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Avoid rename/add conflict when contents are identical
Date: Mon, 9 Aug 2010 21:24:25 +0000
Message-ID: <AANLkTi=tnWy3w1Ek+uvS+QCr4F+An4FfZcHepiTCFGAf@mail.gmail.com>
References: <5C4EA6C5B30E6B45A9164CB3A26A0D326F79D9AA04@azsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Schalk, Ken" <ken.schalk@intel.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 23:24:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiZpg-0000BN-Fy
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 23:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755647Ab0HIVY1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 17:24:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53773 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196Ab0HIVY0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 17:24:26 -0400
Received: by iwn33 with SMTP id 33so3821204iwn.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 14:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nCovHBxRfpSlNXrrlCkyPcjHA+vSCfzsrb3+SEBTVvY=;
        b=OLt5u55Dwv3P6Ilz32rcXwhu3136LVdjDtfujD6DfDBgTI6OtQt6gM0DLV6e50FCAK
         ECiS7nzMr9RoGq/2EVKvSPUkzPk8Kpb3C4PgxcRtW5s+N9ZFqbU8Y6NqI0sUG/I8+4I8
         0sl6ZRea8/4D75pYvzHg18I+ceuwnTXX9PDho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fRgGZH1yidtPaa1UoPr76cABFDVFw/4aF7MCKG6IDlGC2pyRD8ho4WJR8eA609dbY3
         S693O1+KasHQxWFHovrsj1jWnMBosx7masdjtfhyU/aH9PUpK1+DdOD8y6YC66PFPcK+
         xzZrDZKCvptUQY4fpG4olluhnnemqTLIQURbY=
Received: by 10.231.19.198 with SMTP id c6mr19366289ibb.140.1281389065833; 
	Mon, 09 Aug 2010 14:24:25 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Mon, 9 Aug 2010 14:24:25 -0700 (PDT)
In-Reply-To: <5C4EA6C5B30E6B45A9164CB3A26A0D326F79D9AA04@azsmsx503.amr.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153028>

On Mon, Aug 9, 2010 at 21:00, Schalk, Ken <ken.schalk@intel.com> wrote:

> Here's a simple sequence that generates this kind of conflict:
>
> =C2=A0git init
> =C2=A0echo content > fileA
> =C2=A0git add fileA
> =C2=A0git commit -m Initial
> =C2=A0git checkout -b abranch
> =C2=A0mv fileA fileB
> =C2=A0git add fileB
> =C2=A0rm fileA
> =C2=A0ln -s fileB fileA
> =C2=A0git add fileA
> =C2=A0git commit -m Linked
> =C2=A0git checkout master
> =C2=A0git mv fileA fileB
> =C2=A0git add fileB
> =C2=A0git commit -m Moved
> =C2=A0git merge --no-commit abranch

I don't know merge well enough to review the code in this patch, but
the patch would be much better if you turned this sequence of commands
(slightly altered, see t/README) into a now-passing test as part of
the patch.

t/t3030-merge-recursive.sh would be the right place to add it.

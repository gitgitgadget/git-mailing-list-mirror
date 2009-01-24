From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [RFC/PATCH v3 3/3] archive.c: add basic support for submodules
Date: Sat, 24 Jan 2009 21:02:39 +0100
Message-ID: <8c5c35580901241202k5ed436d7y2fafded2f0883c48@mail.gmail.com>
References: <1232659071-14401-1-git-send-email-hjemli@gmail.com>
	 <1232659071-14401-3-git-send-email-hjemli@gmail.com>
	 <1232659071-14401-4-git-send-email-hjemli@gmail.com>
	 <alpine.DEB.1.00.0901230044300.3586@pacific.mpi-cbg.de>
	 <8c5c35580901231040i380c6458x1a6103cd6f55c479@mail.gmail.com>
	 <alpine.DEB.1.00.0901232054360.21467@intel-tinevez-2-302>
	 <8c5c35580901240044y452b465fj94df82fc2b8f7ee9@mail.gmail.com>
	 <alpine.DEB.1.00.0901241443270.13232@racer>
	 <8c5c35580901241126q2da83f50m1472ed017b92c982@mail.gmail.com>
	 <alpine.DEB.1.00.0901242049580.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 24 21:04:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQojo-0002D2-Td
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 21:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbZAXUCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 15:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752895AbZAXUCl
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 15:02:41 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:36602 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbZAXUCk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 15:02:40 -0500
Received: by rv-out-0506.google.com with SMTP id g9so62818rvb.5
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 12:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ft1GL54/CvRxHpmge1HBOu6W2z4GuNXRRun/sSJQ/gw=;
        b=m+XfmGUfvMtiHksd8p8RZBViFmHzKjC8NU9uRTIBjxGF/PUmsKNAvwVMcaxeojT+Vm
         i92mqEOyb1te0cOPzmcNKB3m+f+jWFHfGDoHS0UtNhNMaRkJKxjggDEOtNhIP4pBTah6
         2e4DxlFhBxwCbUlc3VcVDCQfFcK83DX3lSVBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hK9ku4Yy+By2LfYGLiqzxa7f4CoPVCmwk/ZtwTC+Q8F4+L3O7dRI5+EF/m2GquqJq/
         moRH+J9RD63O7/2rRzYIYBp9XjlM15VMa1JtNZCIHHORhdvT8taf+uqlm6IgYCyObrD4
         rR5Phw3k+OiMnay12xzkkWVgFVOAQoNoPANXQ=
Received: by 10.114.196.13 with SMTP id t13mr1052638waf.82.1232827359355; Sat, 
	24 Jan 2009 12:02:39 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901242049580.14855@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107000>

On Sat, Jan 24, 2009 at 20:52, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 24 Jan 2009, Lars Hjemli wrote:
>
>> $ git archive --submodules <tree-ish>: Create an archive which
>> includes the trees of all gitlink entries in <tree-ish>, fail unless
>> all the required objects are available.
>>
>> $ git archive --submodules=<group>: Same as above, but only traverse
>> submodules in the specified group (as defined in $GIT_CONFIG).
>
> How about having the former with --submodules='*' and let --submodules
> without argument include those submodules that are checked out (none in a
> bare repository)?

Yeah, that might make more sense (since you'd normally not have access
to the content of non-checked out submodules). I'm also considering
something like --submodules[=(all|checkedout|[group:]<name>)], i.e.
the 'group:'-part could be optional as long as <name> is unambiguous.

--
larsh

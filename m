From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Explanation for dropping write-back in mmap
Date: Mon, 7 Jun 2010 21:01:50 +0200
Message-ID: <AANLkTinJE5blkIRPp5NDKEWVm2uv-Yelt_niYko6XZa_@mail.gmail.com>
References: <AANLkTilrinkNo9awJ9Wso4tXzQKghWEd2bfDRhPHPOga@mail.gmail.com> 
	<7vbpbmx2er.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 07 21:02:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLhaT-0003Qr-Cc
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 21:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621Ab0FGTCM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jun 2010 15:02:12 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35177 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368Ab0FGTCL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jun 2010 15:02:11 -0400
Received: by gye5 with SMTP id 5so2488906gye.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 12:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=sNCGtJOxwIozHpuHN1a5U/3pFb7ey2ylVxJ7Ppg28Qg=;
        b=iT8NZopSaLD6iU81DwbqXmXr4MlgDPrkhBlbfsxtDyovkw+/hZMUSTAXEmfaqjj/cm
         PL/8gK3LS40GBAaDryEiDMyElzHqAnhLhmJg8Q/vNsC8rz5zdS77y6bgR3oI9eynLXKu
         U8YC8eQExGhb3OqumQHGuYo4/bY7ihgwI2wMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xS4cYLgOMJrqLFFr+ukiwe82FiS2THsPINvQMamR4brHD745gidaNDo+8FXubpUR2N
         +vw0uDuPwaoUGy8wMa/aqO4GJP5IqhHqC6RApoPbv1CIJao2ybiddRPUrpt3ElLMYOKk
         ctofDDJcrojYEqvUDN6aE1G1yRl7KraNIdlBY=
Received: by 10.229.182.131 with SMTP id cc3mr5185264qcb.53.1275937330485; 
	Mon, 07 Jun 2010 12:02:10 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Mon, 7 Jun 2010 12:01:50 -0700 (PDT)
In-Reply-To: <7vbpbmx2er.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148617>

Hi Junio and Shawn,

Shawn O. Pearce wrote:
> I would strongly suggest finding another way to implement the SVN
> exporter, without using MAP_SHARED.

David has already started working on using realloc + persist, but I'd
like to know the reason for your recommendation- is it simply because
mmap with MAP_SHARED is difficult to port, or is there some other
reason as well?

Junio C Hamano wrote:
> I don't think we _dropped_ a _working_ support that allowed shared
> mapping. =C2=A0IIRC the implementation emulated only private mapping =
well
> enough to support the use of mmap() in our codebase (iow, instead of
> allocating a buffer and reading into it and possibly mucking with it
> without affecting outside world, map it to read and then possibly muc=
king
> with it), but lacked input validation to make sure that no caller
> mistakenly thinks the implementation could satisfy non private mappin=
g.

Ah, so you did it for safety/ sanity reasons back then.

> Also I don't think I did this without telling other people---it would=
 be a
> lot more likely that somebody else noticed it and the issue was discu=
ssed
> on the list and resulted in this commit. =C2=A0I would check the comm=
it date
> and see the discussion around that time if I were you to learn the
> backstory.

Right. Thanks for this- I read the "First cut at git port to Cygwin"
thread and learnt the backstory.

-- Ram

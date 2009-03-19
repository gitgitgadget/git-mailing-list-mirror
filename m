From: Yann Simon <yann.simon.fr@gmail.com>
Subject: Re: [PATCH JGIT] Method invokes inefficient new String(String) 
	constructor
Date: Thu, 19 Mar 2009 17:44:22 +0100
Message-ID: <551f769b0903190944ofb03d14u1be316e1dacc1f86@mail.gmail.com>
References: <49C20D4E.5020203@gmail.com> <20090319160102.GQ23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 17:45:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkLNU-0001jy-4H
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 17:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbZCSQo1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 12:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752273AbZCSQo0
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 12:44:26 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:46979 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbZCSQoZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 12:44:25 -0400
Received: by fxm2 with SMTP id 2so582676fxm.37
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 09:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dbsRfbhcH5sE62LtJMx4A56RIGQof8UhoTkXmd8Ljko=;
        b=O2/JIEvSjdydF8ayXIBHOPrTXBlV0pC0kMJqKjBmlBMvKDbPonYdbzNnS6iCP/a/tA
         iSO01rYlz9MUiVxsLSBgG/g1LNruYscflGAj5Y7BWHU3V6+UuaraFEYvX2K7M+GyM1Wc
         nKRmHGOljSS9IdI/C+nbqtlEgzLUlKeDRq418=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Qus1E4nR3dX6l72f2jZ19lbup9uTa4t/Pahiu1NC34B6N2TwYa+/JcTtnLBTBRFapL
         cgoBIC+7ExMYSwJjZ7dfWT+1FlehfPIOffP1ggXRXUI5oKTuFQgTanMn/zqVHyKrVqXf
         Oy24vgiZT8WVXcO1j/vgH7hUqb9RcbCNrC+ss=
Received: by 10.223.115.146 with SMTP id i18mr2292028faq.6.1237481062514; Thu, 
	19 Mar 2009 09:44:22 -0700 (PDT)
In-Reply-To: <20090319160102.GQ23521@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113791>

2009/3/19 Shawn O. Pearce <spearce@spearce.org>:
> The line in question, p, is from the packed-refs file and
> contains the entire SHA-1 in hex form at the beginning of it.
> We've converted that into binary as an ObjectId, it uses 1/4 the
> space of the string portion.
>
> The Ref object, its ObjectId, and its name string, are going to be
> cached in a Map, probably long-term. =C2=A0We're better off shedding =
the
> 80 bytes of memory used to hold the hex SHA-1 then risk substring()
> deciding its "faster" to reuse the char[] then to make a copy of it.

Thany you for the explanation.
I learn something, and my tests confirm it.
The p.substring(...) can keep the entire array of char by only
updating the intern offset value.
new String(p.subtring(...)) make sure that the variable contains only
the final chars.

Yann

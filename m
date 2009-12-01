From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] get_ref_states: strdup entries and free util in stale 
	list
Date: Tue, 1 Dec 2009 16:53:02 +0100
Message-ID: <36ca99e90912010753g1adc13e5v7e2a2b1eebc75183@mail.gmail.com>
References: <0458f16c6ce906997aaf357c0c7368841ae83c36.1259625072.git.bert.wesarg@googlemail.com>
	 <alpine.DEB.1.00.0912010934120.4985@pacific.mpi-cbg.de>
	 <36ca99e90912010105r428a7bfdw63928e8a5515bd1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 01 16:53:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFV2N-0008A7-6P
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 16:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbZLAPw6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 10:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753354AbZLAPw5
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 10:52:57 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:47223 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087AbZLAPw5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 10:52:57 -0500
Received: by fxm5 with SMTP id 5so5044628fxm.28
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 07:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xGew7Nle/asUiJ49f+3zHz3DrsmQPQdFI+7IT/zFqSw=;
        b=vvgzkvK/OOxXgvYIOfWiku33DZLhN8k1Zap6q/6yNIguJucrzIG9fUgXuqm43RIWtu
         qKhux9eKQCkNB5h1lsoX45l4+2ADtsF5VQriMyF7WN2eADcdPPoUWCsyeN1p4L08Tz/4
         zwKtnNb2BGF+3XkzsE0Ml5JfZSjHkc8hpZhqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KE9nsVvyynGDCXVW0t4Pchz1iL1S+Ec2WWqd+lEGnv1Yv89OptKqcT7HPs8JpZOfeu
         hz3yEp1B4joLy+0A9WzZskstn0z4W7d0G9rKQz7imoEJpAvxYsLtqHWOfJKYQAuXxtBe
         VSGr2Y14cdXojNxSxutv638ZrngEmL6VIJsUE=
Received: by 10.223.161.215 with SMTP id s23mr983587fax.44.1259682782716; Tue, 
	01 Dec 2009 07:53:02 -0800 (PST)
In-Reply-To: <36ca99e90912010105r428a7bfdw63928e8a5515bd1d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134215>

On Tue, Dec 1, 2009 at 10:05, Bert Wesarg <bert.wesarg@googlemail.com> =
wrote:
> On Tue, Dec 1, 2009 at 09:35, Johannes Schindelin
>> Thanks. =C2=A0I trust you ran the test suite with valgrind just to m=
ake sure?
> Not the test suite. But my use case where I found the problem (Ie.
> cut-off branch names) which was 'git remote show <remote>'.
> There are still invalid reads of size 4. I think the problem is the
> flex array member of 'struct ref' and strlen(). If its worth I can
> look into this.
I need this new suppression to run the test suite:

diff --git i/t/valgrind/default.supp w/t/valgrind/default.supp
index 9e013fa..39b080a 100644
--- i/t/valgrind/default.supp
+++ w/t/valgrind/default.supp
@@ -43,3 +43,10 @@
        fun:write_buffer
        fun:write_loose_object
 }
+
+{
+       writing-data-from-zlib-triggers-even-more-errors-2
+       Memcheck:Param
+       write(buf)
+       obj:*libpthread-*.so
+}

Bert

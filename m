From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/5] Add generic 'strbuf_readlink()' helper function
Date: Wed, 17 Dec 2008 16:26:36 -0500
Message-ID: <76718490812171326q4d8896c1yb535873c71eec23f@mail.gmail.com>
References: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain>
	 <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 22:28:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD3vw-0004K3-SN
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 22:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbYLQV0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 16:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752664AbYLQV0i
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 16:26:38 -0500
Received: from rv-out-0506.google.com ([209.85.198.237]:62633 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641AbYLQV0h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 16:26:37 -0500
Received: by rv-out-0506.google.com with SMTP id k40so87877rvb.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 13:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=oKNHh1l0W2Mb+37NWdNeXezDJiEh0toYhvkfxQwmfzc=;
        b=k0gHr2e+kMhx5mMpLUgjmWSYrTv33zjKwgNj1CL79W05NzGEdNqD2FHCE79m0q9npK
         HHENXi0F1U5Izz/NqDBUw8Qw+QPDoGBqyd9Ndh2d+W3+JV5eGU1rev+opdXB3JP4v7zJ
         SbEJQcQo0PrDyU0l7dILoG11r9D0NPhD6NPLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qIY+jwDBmQZxWMAM1P/xQxvAxHKBBD4VW3E9/K5Fkqt5HIeMEExvvlmciUK3BN7nIm
         kUghr0InHbln/czt9qYs6/LNTQRTJon6G6az84LliJGRdezS+Fp2kfoQKsAJBZ0msP5f
         3JeRn7MrPv7YQJTdxtjH2lpXe5s8oZeG9D0ck=
Received: by 10.141.98.13 with SMTP id a13mr607546rvm.20.1229549196719;
        Wed, 17 Dec 2008 13:26:36 -0800 (PST)
Received: by 10.141.33.20 with HTTP; Wed, 17 Dec 2008 13:26:36 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103393>

On Wed, Dec 17, 2008 at 1:42 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> +       while (hint < STRBUF_MAXLINK) {
> +               int len;
> +
> +               strbuf_grow(sb, hint);
> +               len = readlink(path, sb->buf, hint);
> +               if (len < 0) {
> +                       if (errno != ERANGE)
> +                               break;
> +               } else if (len < hint) {
> +                       strbuf_setlen(sb, len);
> +                       return 0;
> +               }
> +
> +               /* .. the buffer was too small - try again */
> +               hint *= 2;
> +               continue;
> +       }

Why the continue statement at the end of the loop?

j.

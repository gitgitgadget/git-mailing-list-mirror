From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG PATCH RFC] mailinfo: correctly handle multiline 'Subject:'
 header
Date: Mon, 12 Jan 2009 15:27:44 -0800
Message-ID: <7v63kkgl5b.fsf@gitster.siamese.dyndns.org>
References: <20090108100813.GA15640@myhost>
 <1230316721-14339-1-git-send-email-kirr@mns.spb.ru>
 <20090107224342.GB4946@roro3> <7vy6xm5i6h.fsf@gitster.siamese.dyndns.org>
 <7vy6xm42l3.fsf@gitster.siamese.dyndns.org>
 <1230316721-14339-1-git-send-email-kirr@mns.spb.ru>
 <20090107224342.GB4946@roro3> <7vy6xm5i6h.fsf@gitster.siamese.dyndns.org>
 <20090108231135.GB4185@roro3> <7veizatxo9.fsf@gitster.siamese.dyndns.org>
 <20090112223447.GA5948@roro3.zxlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Potashev <aspotashev@gmail.com>, git@vger.kernel.org
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Tue Jan 13 00:29:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMWDd-00024g-Kf
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 00:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbZALX1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 18:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753377AbZALX1w
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 18:27:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbZALX1v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 18:27:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C84591C57A;
	Mon, 12 Jan 2009 18:27:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 47B811C579; Mon,
 12 Jan 2009 18:27:45 -0500 (EST)
In-Reply-To: <20090112223447.GA5948@roro3.zxlink> (Kirill Smelkov's message
 of "Tue, 13 Jan 2009 01:34:47 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A0FB9792-E100-11DD-89BE-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105414>

Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:

> diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
> index f7c8c08..6d72c1b 100644
> --- a/builtin-mailinfo.c
> +++ b/builtin-mailinfo.c
> @@ -860,6 +860,7 @@ static void handle_info(void)
>  			}
>  			output_header_lines(fout, "Subject", hdr);
>  		} else if (!memcmp(header[i], "From", 4)) {
> +			cleanup_space(hdr);
>  			handle_from(hdr);
>  			fprintf(fout, "Author: %s\n", name.buf);
>  			fprintf(fout, "Email: %s\n", email.buf);
> diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
> index 4bf7947..d465685 100644
> --- a/t/t5100/sample.mbox
> +++ b/t/t5100/sample.mbox
> @@ -2,7 +2,10 @@
>  	
>      
>  From nobody Mon Sep 17 00:00:00 2001
> -From: A U Thor <a.u.thor@example.com>
> +From: A
> +      U
> +      Thor
> +      <a.u.thor@example.com>
>  Date: Fri, 9 Jun 2006 00:44:16 -0700
>  Subject: [PATCH] a commit.

I think this is a reasonable change.

But doesn't this

>  From nobody Mon Sep 17 00:00:00 2001
> -From: A
> +From: A (zzz)
>        U
>        Thor
> -      <a.u.thor@example.com>
> +      <a.u.thor@example.com> (Comment)

regress for people who spell their names like this?

	From: john.doe@email.xz (John Doe)

From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] show-branch: fix segfault when showbranch.default exists
Date: Tue, 09 Jun 2009 00:17:28 -0700
Message-ID: <4A2E0C88.70805@gmail.com>
References: <7vfxe9udln.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 09:17:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDvaX-0000YV-9P
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 09:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755689AbZFIHRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 03:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755573AbZFIHRb
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 03:17:31 -0400
Received: from mail-px0-f200.google.com ([209.85.216.200]:62799 "EHLO
	mail-px0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755111AbZFIHRb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 03:17:31 -0400
Received: by pxi38 with SMTP id 38so645210pxi.33
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 00:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=1SpCyfs5XJ/mnt5bzAJH7maCPrPwx+kBpv8tpOSkzig=;
        b=x579ek1flJCx49IvXB0htde0ZzcQUPr9O3v+G6J9IOGr++9xvjv0wITHGnelYZ+4PY
         Tq8NPML9Ww3jbOaUk2Khxiu0NxqVs0pSUtpK/S26agFlRrZSBamI5KbaJf91MZCQ8Z0P
         n2EXGzKd2UZQdUSQr0i07AbhKAHn0rCceTkL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=xvdBOWYWqZ3Dz3+giH8I3xsIq1wx7rIq8w/PgFvOX/fYeGeb8AUDRkhwdHTEizYXFH
         xY/nwKzlqitNGluNnvZR2GUfhg/gSxvOzvFo6jxwY1YGQkE37ST6nigZHYGliY1IKaLW
         W4MvMnUNSsOukezDRI2E03fSiG208syvDsHKk=
Received: by 10.114.130.15 with SMTP id c15mr11907296wad.59.1244531851690;
        Tue, 09 Jun 2009 00:17:31 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id k21sm6942283waf.59.2009.06.09.00.17.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Jun 2009 00:17:30 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <7vfxe9udln.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121146>

Junio C Hamano wrote:
> I am not sure if this is a bug in parse_options(), or a bug in the caller,
> and tonight I do not have enough concentration to figure out which.  In
> any case, this patch works the issue around.

I am low on concentration tonight as well, but this looks right to me.
Parse options is expecting the regular old argv and argc. I overlooked
this code path during the conversion (though I remember figuring out
what this path was doing). Faking the argv and argc a little more
accurately, like you do, should work fine.

On a side note, I can't remember why I used 
PARSE_OPT_STOP_AT_NON_OPTION. I think it should be 0.

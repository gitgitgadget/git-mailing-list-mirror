From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [RFC] ll-merge: Normalize files before merging
Date: Fri, 11 Jun 2010 22:56:08 +0200
Message-ID: <FD073505-FFF4-40D7-B841-0EC1B902E32E@gmail.com>
References: <1276202894-11805-1-git-send-email-eyvind.bernhardsen@gmail.com> <4C11CE75.7080706@viscovery.net> <4C11E717.4070508@gmail.com> <4C11EB0D.20208@viscovery.net> <7vd3vxicaw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 22:56:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONBH6-0001UL-BJ
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 22:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757889Ab0FKU4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 16:56:13 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50610 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248Ab0FKU4M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jun 2010 16:56:12 -0400
Received: by wyb40 with SMTP id 40so1176655wyb.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 13:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=Fz3jF4TXwcB1lbYplIETc59+LqTgpVerIfHc3PuEl4Q=;
        b=QJG8QA4DzEqnQRWABtP0Sc2RDy+fsxufcSSQJvpLM1NlyB0aMyLVyrAxcAyttdyqGR
         SKO0eHVpJj2drxXMCG4KtCBjs8T0N5eVvNlbkacSm0mKve4OIs5D98WAJMmzJuBxPAdf
         7M+FeQTtIEsO2AelXBAw8imkWbp7aMfGTLK80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=dBu4/9qEAVJZ1YHP/5idMUUHYjJo2yTPyDarj65hyHvNtcmu6N7xwqShGWgjv9omN4
         qVCzNQouYqjgTRYw4pWbDXKfKcegpqtoZxNk/0owHeBmLgTT3AJ8bQR1hxKT4BWodc6M
         eCYV0egtFZ1MDUkC5yhtlqFm9ijIaeTeoVmnE=
Received: by 10.227.146.3 with SMTP id f3mr2423054wbv.211.1276289770095;
        Fri, 11 Jun 2010 13:56:10 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id b17sm12090431wbd.7.2010.06.11.13.56.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Jun 2010 13:56:09 -0700 (PDT)
In-Reply-To: <7vd3vxicaw.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148970>

On 11. juni 2010, at 21.44, Junio C Hamano wrote:

> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> I know what your point is. It is still inappropriate to call
>> normalize_file() on data that comes from the repository. It is not the
>> task of a merge procedure to blindly normalize data.
> 
> It is not "blindly", but "running normalization one _extra time_, as the
> repository data is supposed to be canonical already", which is utterly
> wrong.

I agree that double normalization is evil, but the repository data isn't necessarily canonical if the configuration has changed since the data was added.

How do you feel about Finn Arne's idea of first convert_to_work_tree()-ing the data, then convert_to_git()ing it back?  That gets rid of the double normalization at the cost of some performance and memory usage (especially with CRLF output enabled).  I'm going to do some benchmarks to go along with my next stab at this.

- Eyvind

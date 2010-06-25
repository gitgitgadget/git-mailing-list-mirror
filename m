From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH v3 3/3] Don't expand CRLFs when normalizing text during merge
Date: Fri, 25 Jun 2010 10:58:54 +0200
Message-ID: <EE9F4F92-06D5-4B31-BF6F-1163774C112B@gmail.com>
References: <cover.1277408598.git.eyvind.bernhardsen@gmail.com> <90f38b5f5c49f9b9f5427a026e51f867a1121982.1277408598.git.eyvind.bernhardsen@gmail.com> <4C244278.10407@viscovery.net> <FB02F1B0-9FE7-4B7B-BA30-5A510F83BCE7@gmail.com> <4C246622.9090707@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jun 25 10:59:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OS4kf-0006ai-C2
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 10:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371Ab0FYI7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 04:59:01 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:63725 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113Ab0FYI7A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 04:59:00 -0400
Received: by wwi17 with SMTP id 17so871496wwi.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 01:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:in-reply-to
         :mime-version:content-type:message-id:content-transfer-encoding:cc
         :from:subject:date:to:x-mailer;
        bh=2ZXeIytZktNPAhdJ/LIzoezQtQ1qnuG3gkjUGyORWaM=;
        b=jLeZ9eyVrHyhh3J4FJVRRACAh3FQ5gbGNS38Jxi1qLuQXhZY1oUpTpLoMcjPyYv4qz
         u7ioigHDV1OTDENJhULWgGvaJuFmGcWRYPDv+/Ti5vV0JClqeaTlhyVeJ//7I8jhexbE
         iRVPPVnlesXjKSV0hobFk8YRrjBodZ8teFIqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-type:message-id
         :content-transfer-encoding:cc:from:subject:date:to:x-mailer;
        b=csNJwkkgr+G9w6NfmZCoJrKQQO6RKKrkKzRLl95wocO4KZVYKaTNO3NNEyR9i4Jhve
         unxu0K19A4XNqW7MISIK3LT5+jDDXMvm1T/RLSxjfsa2QU6dCYH4iwnepxn+urAGsYuc
         XWx8U+KSOvcKGSlHXLC1nZNdPPCW91ec2GlYQ=
Received: by 10.227.128.129 with SMTP id k1mr295757wbs.32.1277456338004;
        Fri, 25 Jun 2010 01:58:58 -0700 (PDT)
Received: from [10.36.80.159] ([62.113.137.5])
        by mx.google.com with ESMTPS id y31sm57997409wby.16.2010.06.25.01.58.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Jun 2010 01:58:57 -0700 (PDT)
In-Reply-To: <4C246622.9090707@viscovery.net>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149673>

On 25. juni 2010, at 10.17, Johannes Sixt wrote:

> Am 6/25/2010 9:58, schrieb Eyvind Bernhardsen:
>> Sorry, I didn't explain that very well.  I noticed that normalize_buffer()
>> does more work when core.eol=crlf than it does when core.eol=lf:
>> _to_working_tree() converts LF to CRLF, and then _to_git() reverses that
>> conversion.  This patch makes normalization act the same way when
>> core.eol=crlf as it does when core.eol=lf.
> 
> Got it: I missed that you are omitting the conversion only on the "way
> out" but not on the "way back".
> 
> Looking more closely at your patch, I think that you should make this
> optimization only if you can prove that the subsequent apply_filter() is a
> no-op. Otherwise, you may break a smudge filter that expects CRLFs.

Such a smudge filter would break when core.eol=lf, but you're suggesting that someone might be using a picky smudge filter and has set core.eol=crlf to make sure it gets the line endings it expects?

That's a very good catch.  I'll add a test so that the optimization is only done if filter is NULL.
-- 
Eyvind Bernhardsen

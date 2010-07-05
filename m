From: Jakub Narebski <jnareb@gmail.com>
Subject: [BUG] Spurious leading '/' in filename in "git diff --raw --relative=<subdirectory>"
Date: Mon, 5 Jul 2010 10:15:23 +0200
Message-ID: <201007051015.26995.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 05 10:15:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVgqF-0001VE-1Q
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 10:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756381Ab0GEIPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 04:15:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36096 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965Ab0GEIPm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 04:15:42 -0400
Received: by fxm14 with SMTP id 14so3411917fxm.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 01:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=QhBPJq/CIo0kArGcgO/nYPNOfNBwlwfQlfZhpM7r4As=;
        b=VOsIX2mP10GgUPQLqYiOKJC2Ck8sGXFeAA0dFgy/7Qs/vFUvFBVz3ro020H7lrcjP5
         4+JUm/IyrmmrfjwVfl5AYsUJpIsO2HE+5BPbIpkc/3ta4Kaj9EPlnAMnlDWeaiaaZdgm
         1rTX9ACxYE2Cu5jZNEIF5Gmp0yX9dGj+lyfAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=fTWlZewOB3Ea/C0Me6vlHpjQISkoOHXFxWckO10rB1hv5JF01lVe7acCxvZf2679n/
         5oEOunpqbuy+n35/QyFB//UdDRiyiQ5YNojpagVMAlPHxFBTw7+GqaBasNpYYs89WK12
         C0E32J4c28XUFO9p3ZRxfqkZpSNnzLz/ez2gg=
Received: by 10.86.77.2 with SMTP id z2mr1508286fga.67.1278317740630;
        Mon, 05 Jul 2010 01:15:40 -0700 (PDT)
Received: from [192.168.1.15] ([83.8.222.158])
        by mx.google.com with ESMTPS id h14sm8547613faa.23.2010.07.05.01.15.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Jul 2010 01:15:40 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150248>

I wanted to get non-recursive raw diff (difftree), but for a given
subdirectory and not starting from root.  

I have found '--relative[=<path>]', introduced in 

  c0cb4a0 (diff --relative: help working in a bare repository, 2008-02-13)
  cd676a5 (diff --relative: output paths as relative to the current subdirectory, 2008-02-12)

But when examining it's output in 'raw' mode, I have notice spurious
leading '/' in filename:

  $ git diff-tree --abbrev -r --raw HEAD --relative=sub
  a3a8425fe5496c61921010cb1e7b455a1f52bb86
  :100644 100644 d90bda0... cefcae0... M	/quux

The output without '-r' (recurse into sub-trees) is even more strange

  $ git diff-tree --abbrev --raw HEAD --relative=sub
  a3a8425fe5496c61921010cb1e7b455a1f52bb86
  :040000 040000 e62aa6e... b5d4a43... M	

(that's a trailing TAB, and no filename).

What I expected was the following output:

  $ git diff-tree --abbrev --raw HEAD --relative=sub
  a3a8425fe5496c61921010cb1e7b455a1f52bb86
  :040000 040000 e62aa6e... b5d4a43... M	quux


I see that the '--relative' and '--relative=<path>' options were introduced
for patch ('-p') format, and not for difftree / raw format, but I think
they should work for it, too.


P.S. I have noticed this bug when working on proof-of-concept tree-blame
(i.e. when given file was modified) in Perl.
-- 
Jakub Narebski
Poland

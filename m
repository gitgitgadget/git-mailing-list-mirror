From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 00/14] Sparse checkout
Date: Mon, 22 Sep 2008 00:14:15 +0200
Message-ID: <200809220014.17970.jnareb@gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com> <200809211249.10016.jnareb@gmail.com> <fcaeb9bf0809210432x500cf586k877d07b335bf33de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 00:15:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhXDK-0004nh-4L
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 00:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbYIUWOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 18:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752555AbYIUWOY
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 18:14:24 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:16062 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbYIUWOY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 18:14:24 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1269151fkq.5
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 15:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=MbDFik5LtAQKBQS0ONJKAMoAKEM+0QcmznAmgkgvpD8=;
        b=SaYlOertXUi69ljFsMDaLd1LJ20/5SEpyCRJQNyDjR9YWWtuPbeMNNSTsAErFyz4mV
         ha9l82v/BFDkVLTMvmgHl66GG7NSQ4sz4+KaKNppfkCGspGQuJWBvIOK90EjWFGieqoS
         PGPftJEgEgrE4HoslZwNzXk+3DaX3WxRraJCA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=RDPKx4KLxgVJ4X42k7JIElpfVlxIV4V+N4Y3ETQQpYrCACw8xfyA+VTWUDmxXh+m8r
         T57m5Jl74EXWsvaNLkl4gkFb1uK/P4d0hqLdHQUgkr/r8vrYNu76WChMzUu5mmFU8ZtJ
         cSaL/iEOsjOXxfSrEVBgnqeTHRddQB69mi/uc=
Received: by 10.103.217.7 with SMTP id u7mr2116765muq.102.1222035262172;
        Sun, 21 Sep 2008 15:14:22 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.206.218])
        by mx.google.com with ESMTPS id y6sm21549920mug.7.2008.09.21.15.14.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Sep 2008 15:14:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <fcaeb9bf0809210432x500cf586k877d07b335bf33de@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96441>

On Sun, 21 Sep 2008, Nguyen Thai Ngoc Duy wrote:
> On 9/21/08, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Sun, 21 Sep 2008, Nguyen Thai Ngoc Duy wrote:
>>> On 9/21/08, Junio C Hamano <gitster@pobox.com> wrote:

> [...] Checking the source again, I
> misunderstood  gitattributes/gitingore's leading '/' notion (in a good
> way). Leading '/' means './' and that would be fine for
> .git{attributes,ignore}. 

By the way it would be nice if gitignore accepted './' as equivalent
to current '/', as this is something I think (from questions here
and on #git) that people expect to work (not reading documentation
carefully enough).  This is something that for example `ls' would use,
or something that `find' returns.

> In sparse patterns, leading '/' means toplevel directory because you
> may want to checkout some more from a subdirectory without moving up
> to toplevel directory. Now .git{ignore,attributes} and sparse patterns
> are incompatible, gaah... 

Well, this doesn't make sense in a _file_, but makes perfect sense when
invoked from _command line_, as option argument.

But I was thinking more about centralizing pattern matching wrt either
full pathname (with prefix stripped, or not), or basename of a file.
If match check is centralized, then if you enhance pattern language (for
selecting which files to mark no-checkout in sparse checkout for example
by allowing '**' which matches also '/' (if you don't go route of 'tar'
with '--wildcards-match-slash' option)), then it would enhance gitignore
patterns and gitattributes patterns too (well, excluding the fact that
they are delimited differently).
 
>>  Second, while unifying the "check the match" part of gitignore,
>>  gitattribute and sparse checkout would be IMVHO a good idea, [...]
> 
> It is surely good. Optimization like 68492fc (Speedup scanning for
> excluded files.) could be applied to .gitattributes too. Now I know
> why I was confused when reading the matching part of
> .git{attributes,ignore}.

And all speedups (well, perhaps not all) would apply to all classes
of matching against patterns as well.
-- 
Jakub Narebski
Poland

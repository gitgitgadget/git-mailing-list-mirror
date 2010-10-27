From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH v2 0/3] Documentation: refactor config variable descriptions
Date: Wed, 27 Oct 2010 12:56:15 +0200
Message-ID: <201010271256.16836.jnareb@gmail.com>
References: <cover.1287690696.git.trast@student.ethz.ch> <20101025151125.GD28278@sigill.intra.peff.net> <201010251749.04784.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 27 12:56:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB3gI-0005tz-7y
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 12:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910Ab0J0K4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 06:56:31 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42225 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351Ab0J0K4a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 06:56:30 -0400
Received: by bwz11 with SMTP id 11so400860bwz.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 03:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=asLsj3iICJtayTXIO59atNq6JtdbNBUE672pFi245U8=;
        b=H2c6ZOuW9rTcFm0k8XnJFpl6q/dpgO/qlwaOn5PTlJtymkaG3PVYTil3SjUydpg1oT
         k/mqWrHNZR4UXPjYwZUlHUpRhnhvcFI/9WB15v8qEq4H21rvv8IlAF0aDQhdWvHbmr2O
         eePQ2NHALhVtm8Sp1SwMXKwWIR1FZQlZucE+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DFkxVn53rWXjY/XJzIu23RikWFJWgs2O19SbVGxgVncvJHZC8DaOHcRicnT64or1sI
         wYqzqWXA4b+ffkr2NcnKRtQhfrmlgdu6ejYsBw4sDvmVZZKM/rPCnXEvLuVRKxPoeDPF
         No+9Eyco/Z67yoAE2htVO07EtQsm15N5g71UM=
Received: by 10.204.163.142 with SMTP id a14mr6281911bky.126.1288176988394;
        Wed, 27 Oct 2010 03:56:28 -0700 (PDT)
Received: from [192.168.1.13] (abvr250.neoplus.adsl.tpnet.pl [83.8.215.250])
        by mx.google.com with ESMTPS id t10sm6854511bkj.16.2010.10.27.03.56.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 03:56:24 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201010251749.04784.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160033>

On Mon, 25 Oct 2010, Jakub Narebski wrote:
> On Mon, 25 Oct 2010, Jeff King wrote:
>> On Mon, Oct 25, 2010 at 02:44:06PM +0200, Jakub Narebski wrote:

>>>>   2. You recursively follow includes via include::. This means that the
>>>>      make rule is not accurate. E.g., try:
>>> [...]
>>> We do that: see 'doc.dep' target in Documentation/Makefile.  We just
>>> need for this target to also add dependencies for config-vars.txt
>>> (perhaps separate mode for make-config-list.perl, or perhaps 
>>> build-docdep.perl should be config-vars-src.txt aware...).
>> 
>> Yeah, that would definitely work.

The part of patch (commit) touching Documentation/Makefile could look
like this:

-- 8< --
diff --git a/Documentation/Makefile b/Documentation/Makefile
index e117bc4..351aa9c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -212,9 +212,12 @@ install-html: html
 #
 # Determine "include::" file references in asciidoc files.
 #
-doc.dep : $(wildcard *.txt) build-docdep.perl
+doc.dep : $(wildcard *.txt) build-docdep.perl make-config-list.perl
 	$(QUIET_GEN)$(RM) $@+ $@ && \
 	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
+	$(PERL_PATH) ./make-config-list.perl --deps=config-vars.txt \
+		--mainlist=config-vars-src.txt $(MAN_TXT) \
+		>>$@+ $(QUIET_STDERR) && \
 	mv $@+ $@
 
 -include doc.dep
@@ -320,6 +323,11 @@ howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
 	'$(SHELL_PATH_SQ)' ./howto-index.sh $(wildcard howto/*.txt) >$@+ && \
 	mv $@+ $@
 
+config-vars.txt: config-vars-src.txt $(MAN_TXT) make-config-list.perl
+	$(PERL_PATH) ./make-config-list.perl \
+		--mainlist=$< --ignore=$@ $(MAN_TXT) >$@+ && \
+	mv $@+ $@
+
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
 	$(QUIET_ASCIIDOC)$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b xhtml11 $*.txt
 
-- >8 --

Note that while in rule for config-vars.txt target we can use automatic
variables, we have to spell filenames in full in the part of doc.dep
rules that generate dependency for config-vars.txt.  Note also that we
have to keep those explicit and implicit filenames in sync across those
two rules.
 
> Though simpler would be just to not use or turn off following includes,
> as it turned out that it doesn't matter to follow includes in manpages:
> if we include with config variables, it is to also include it in 
> config-vars-src.txt.
> 
> Well, assuming that we don't have to follow includes in config-vars-src.txt;
> otherwise we have to generate line in doc.dep for that include anyway.

Decision time!!!

There are two possible approaches:

1. Don't follow includes in manpages (in manpage sources), and don't follow
   includes in config-vars-src.txt

   Advantages:
   * Less code to write and maintain
   * No need to keep filenames in rule for config-vars.txt and for doc.dep
     in sync.

   Disadvantages:
   * Theoretically fragile: it depends on two assumptions:

     A. If file included in manpage contains description of config vars,
        then this file would be included also in config-vars-src.txt

     B. For config variables inside file(s) included by config-vars-src.txt,
        if they are present in individual manpage, it is done by inclusion
        of said file.

     Those assumptions are two sides of the same coin, and can be written
     as: file included in manpagee can contain config variables if and only
     if it is included in config-vars-src.txt

2. Follow includes both in manpages and in config-vars-src.txt, and
   generate dependencies for config-vars.txt

   Advantages:
   * More generic solution

   Disadvantages:
   * Need to keep rules for doc.dep and for config-vars.txt in sync, as
     described above
   * config-vars.txt rule has more dependencies.

Now, which one to choose?
-- 
Jakub Narebski
Poland

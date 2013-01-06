From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix man page dependency on asciidoc.conf
Date: Sat, 05 Jan 2013 22:51:10 -0800
Message-ID: <7vbod2pzxd.fsf@alter.siamese.dyndns.org>
References: <20130105160017.GD6440@serenity.lan>
 <20130105232800.GF3247@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Sergey Vlasov <vsu@altlinux.ru>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 07:52:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trk5l-00020h-Rr
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996Ab3AFGvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 01:51:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41423 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881Ab3AFGvN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 01:51:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D11F57041;
	Sun,  6 Jan 2013 01:51:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/HGONhI70y+bqSPbRb7oNOwsmyY=; b=G+0xg8
	WuTZdzpLiiO5Nb46V1rjMv1IpBLD4dXpgUq1y/eA41rhpC58FYX89uruyT32cjha
	7NLp8UDPoWVoag0UI8VgQ3emRCBW0KzANHU3JSFV7ZzoNK2ing9nHy9GbizizrW4
	cUxQHQXvOFHaWrTedWCs0wACSl+GL13j/hvf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M0l6gK+VjtmiqkEovITprea2cuI+4auQ
	blvr6MZFqCXZBu2hMV2iKaDX+OhTVlAmv4aEaXsejQ1FNKvWqeF0XD9r0hrqH5Vl
	iTlhl6AVd29otx5IfhHxcwEIy/v9FdOOsA4fIoRu2cx7TDxBaTTsRxrN+diknQxW
	0xyIqv1cOwY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C206A7040;
	Sun,  6 Jan 2013 01:51:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F1AA703E; Sun,  6 Jan 2013
 01:51:11 -0500 (EST)
In-Reply-To: <20130105232800.GF3247@elie.Belkin> (Jonathan Nieder's message
 of "Sat, 5 Jan 2013 15:28:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7532C692-57CD-11E2-BC6A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212779>

Jonathan Nieder <jrnieder@gmail.com> writes:

> John Keeping wrote:
>
>> When building manual pages, the source text is transformed to XML with
>> AsciiDoc before the man pages are generated from the XML with xmlto.
>>
>> Fix the dependency in the Makefile so that the XML files are rebuilt
>> when asciidoc.conf changes and not just the manual pages from unchanged
>> XML.
>
> Good catch, thanks.
>
> Would something like the following make sense, to make it more obvious
> how the dependency needs to be adjusted if we change the $(ASCIIDOC)
> command line for some reason?

I think such a more explicit approach is easier to understand, than
a separate "By the way, I do not define any rule to build these
targets using asciidoc.conf, but I know they depend on it" rule.

Care to do a real patch?

Thanks.


> diff --git i/Documentation/Makefile w/Documentation/Makefile
> index e53d333e..971977b8 100644
> --- i/Documentation/Makefile
> +++ w/Documentation/Makefile
> @@ -178,8 +178,6 @@ all: html man
>  
>  html: $(DOC_HTML)
>  
> -$(DOC_HTML) $(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7): asciidoc.conf
> -
>  man: man1 man5 man7
>  man1: $(DOC_MAN1)
>  man5: $(DOC_MAN5)
> @@ -257,7 +255,7 @@ clean:
>  	$(RM) $(cmds_txt) *.made
>  	$(RM) manpage-base-url.xsl
>  
> -$(MAN_HTML): %.html : %.txt
> +$(MAN_HTML): %.html : %.txt asciidoc.conf
>  	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
>  	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
>  		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
> @@ -270,7 +268,7 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
>  	$(QUIET_XMLTO)$(RM) $@ && \
>  	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
>  
> -%.xml : %.txt
> +%.xml : %.txt asciidoc.conf
>  	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
>  	$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf \
>  		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
> @@ -286,7 +284,7 @@ technical/api-index.txt: technical/api-index-skel.txt \
>  	$(QUIET_GEN)cd technical && '$(SHELL_PATH_SQ)' ./api-index.sh
>  
>  technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
> -$(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt
> +$(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt asciidoc.conf
>  	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b xhtml11 -f asciidoc.conf \
>  		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) $*.txt
>  
> diff --git i/t/test-terminal.perl w/t/test-terminal.perl
> index 10172aee..1fb373f2 100755
> --- i/t/test-terminal.perl
> +++ w/t/test-terminal.perl
> @@ -31,7 +31,7 @@ sub finish_child {
>  	} elsif ($? & 127) {
>  		my $code = $? & 127;
>  		warn "died of signal $code";
> -		return $code - 128;
> +		return $code + 128;
>  	} else {
>  		return $? >> 8;
>  	}

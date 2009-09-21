From: Junio C Hamano <gitster@pobox.com>
Subject: Re: install does not obey DESTDIR or --prefix for perl modules
Date: Mon, 21 Sep 2009 12:44:05 -0700
Message-ID: <7vocp4ulq2.fsf@alter.siamese.dyndns.org>
References: <20090921160551.GD8173@gryning.com>
 <Ow6bpZou9Vi0tKlyAN-qfjlAAtXvMqpXEAiG54zZ3C8fLI_6_Bt3oA@cipher.nrlssc.navy.mil> <7vskeguqmb.fsf@alter.siamese.dyndns.org> <20090921191943.GE8173@gryning.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	git@vger.kernel.org
To: c@gryning.com
X-From: git-owner@vger.kernel.org Mon Sep 21 21:44:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpooC-0003RH-C3
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 21:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415AbZIUToN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 15:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbZIUToN
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 15:44:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46802 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210AbZIUToM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 15:44:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9FA6B5A077;
	Mon, 21 Sep 2009 15:44:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lIbWH+pT/9Zhy1MkKoiJNfZQeKs=; b=TC0IhB
	WlFuUPd3MlWr8DwQ2GYnrNTZ5JVI+iuMsaZRynP/Q9eJzjFTVgNh47c3g7nCF+wm
	N7OVaiD28aaPqSsPgg86kGM7PfSCRZKDTPc/ybPNUrgXvShYtmAuTNaQS6ygQnLg
	Ilk7H/i9fUUiWKcGCV3dVx/J1G6RXTZSmj+8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fvrOLxTCfb4CPMFu6eM5q4CV1HZ+RN88
	3csTJ9yKeJo0DyW9+xGuGE3xLM+UXbm8E28ZA86CUxJzy51SMOCpM1HlSVHQogA+
	oZtNLe0EK2cj2DZgFkZVK4y2ggeiHQdFLEe2QvNxcapyxlk6IdXgBEx0itSEW9fb
	trVKQ8S/bIk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 762055A073;
	Mon, 21 Sep 2009 15:44:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id ED13C5A072; Mon, 21 Sep 2009
 15:44:06 -0400 (EDT)
In-Reply-To: <20090921191943.GE8173@gryning.com> (Craig Taylor's message of
 "Mon\, 21 Sep 2009 20\:19\:43 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 227F10BC-A6E7-11DE-8B61-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128905>

Craig Taylor <c@gryning.com> writes:

> Exactly as you describe here, different paths but same goal.
> All binaries follow the DESTDIR path except the perl modules.
>
> To register this as a bug do I need to do more than send this email?

Do you use NO_PERL_MAKEMAKER in your build?

If not, we need to summon an expert on ExtUtils::MakeMaker to look into
this issue, but if you do, perhaps you can try this patch and report how
well it works for you.

---
 perl/Makefile |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/perl/Makefile b/perl/Makefile
index e3dd1a5..4ab21d6 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -29,11 +29,11 @@ $(makfile): ../GIT-CFLAGS Makefile
 	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
 	echo '	cp private-Error.pm blib/lib/Error.pm' >> $@
 	echo install: >> $@
-	echo '	mkdir -p "$(instdir_SQ)"' >> $@
-	echo '	$(RM) "$(instdir_SQ)/Git.pm"; cp Git.pm "$(instdir_SQ)"' >> $@
-	echo '	$(RM) "$(instdir_SQ)/Error.pm"' >> $@
+	echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)"' >> $@
+	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Git.pm"; cp Git.pm "$$(DESTDIR)$(instdir_SQ)"' >> $@
+	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
 	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
-	echo '	cp private-Error.pm "$(instdir_SQ)/Error.pm"' >> $@
+	echo '	cp private-Error.pm "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
 	echo instlibdir: >> $@
 	echo '	echo $(instdir_SQ)' >> $@
 else

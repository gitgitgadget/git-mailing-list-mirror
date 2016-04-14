From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Thu, 14 Apr 2016 13:02:12 -0400
Organization: Twitter
Message-ID: <1460653332.5540.84.camel@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
	 <1460507589-25525-4-git-send-email-dturner@twopensource.com>
	 <xmqqy48ggmcs.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pclouds@gmail.co,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 19:02:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqkeq-0004dO-NG
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 19:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933097AbcDNRCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 13:02:16 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:33195 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099AbcDNRCP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 13:02:15 -0400
Received: by mail-qg0-f45.google.com with SMTP id j35so66677894qge.0
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 10:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=fJSiEc9KTj5f/dG5SxxhPc0hsmIPbarmPgw7s8IYGaE=;
        b=L7NyKlyJfOXmR/yAj5HCzqY6++52el2qo+DpLE2E5hIJMINmScMI58Vx+/wYJx2GRX
         4/u2UTHmpIlt1eSTHxu2Gmp5WaNu81mrMzwN4vXGSzNhIijiPY2n/buDwBIhugO3WtwH
         XJelZNAdzR9WGobbgpz75xb44J06QYgBF2zgFvh6MqDeolSsffggaJlc1GhhTd2liz8H
         GPQsBSFswV9pxQv3wqMRHktOc9t9OJlye+dTgGb8tQDSoSji0zlLjY09lujOuUe+AnOf
         gDJStoGxxxez3bZ7/YfqXmbkwBli3KNY3w6AFdaCzCeoZoIj2vGw4c1YRaUi3nZ7kgZd
         qBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=fJSiEc9KTj5f/dG5SxxhPc0hsmIPbarmPgw7s8IYGaE=;
        b=FKdG+mgA4VjQz+8cVSuUYJCogJSKihtvSOAZmfRp6i11KvY4jHWSLULv2a/poNOXsz
         2l5KDg49ceEb6kj4J7YYeDMohOCPBn8u/SZX1grW8Rwm1tACvJhcSNv3oakMSOQqJmEK
         fQris7jxTRtLqjPs6y/beCnLI7fV8jKi+uRdSVItHRwuZXMnE9kGVyKzaOEUlO/IUOuC
         URhDIlB4t089jVkeYYOg5vtFYqHb4+/QmPstAZNAtwqt1gH7CHrB189Scw1doAjbcACm
         kLjZV7hIMxws4YpUV7NWVFrd9JQQVMbibsKBR1wuMa5RSNldl2Z3bIxgqWEhShm0y2p6
         3RFQ==
X-Gm-Message-State: AOPr4FVlTqt+k/Jzjgylnj01zigdo0ab1VSmyG7SYEkAXPwoFXlkgeI+bTJpHM6mVZ6DBw==
X-Received: by 10.140.34.133 with SMTP id l5mr19454206qgl.27.1460653334244;
        Thu, 14 Apr 2016 10:02:14 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id y129sm18555203qka.33.2016.04.14.10.02.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Apr 2016 10:02:13 -0700 (PDT)
In-Reply-To: <xmqqy48ggmcs.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291535>

On Thu, 2016-04-14 at 09:56 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > $GIT_DIR/index-helper.path is a symlink to the socket for the
> > daemon
> > process. The daemon reads from the socket and executes commands.
> 
> We generally avoid using symbolic links inside $GIT_DIR (we used to
> represent the current branch by a symbolic link HEAD pointing at the
> underlying ref, but switched to the textual symref long time ago,
> and we did the ".git pointing at the real repository location" to
> support submodules also in a similar way).
> 
> I wonder if we can change this to a file that records the location
> of the socket without bending over backwards too much?
> 
> > Named pipes were considered for portability reasons, but then
> > commands
> > that need replies from the daemon would have open their own pipes,
> > since a named pipe should only have one reader.  Unix domain
> > sockets
> > don't have this problem.
> > 
> > On webkit.git with index format v2, duplicating 8 times to 1.4m
> > entries and 200MB in size:
> > 
> > (vanilla)      0.986986364 s: read_index_from .git/index
> > (index-helper) 0.267850279 s: read_index_from .git/index
> > 
> > Interestingly with index v4, we get less out of index-helper. It
> > makes
> > sense as v4 requires more processing after loading the index:
> > 
> > (vanilla)      0.722496666 s: read_index_from .git/index
> > (index-helper) 0.302741500 s: read_index_from .git/index
> > 
> > (these benchmarks are from an earlier version of this patch, but
> > should
> > still be valid).
> 
> Just something to keep in mind; we'd need to see updated numbers
> when the series matures.

I don't actually know how Duy did the index duplication for this
benchmark.  Duy?

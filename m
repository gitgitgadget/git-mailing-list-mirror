From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/4] update-index: migrate to parse-options API
Date: Sun, 24 Oct 2010 03:13:16 -0500
Message-ID: <20101024081316.GA29630@burratino>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino>
 <20101022064258.GB6081@burratino>
 <7v8w1qnkr1.fsf@alter.siamese.dyndns.org>
 <20101024072032.GA23455@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 24 10:17:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9vlr-0001HG-Ts
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 10:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166Ab0JXIRN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Oct 2010 04:17:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47919 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160Ab0JXIRL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 04:17:11 -0400
Received: by iwn34 with SMTP id 34so2936529iwn.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 01:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=eFnCTR2EzpWqZiBf0YrMedHq0Eux2OnSMOUHujfnpcE=;
        b=fM6JuLdjxHvybsQ3ovJg9xiKOXkf1lDf8P6/E/4Y73ziAAgj89XketspMm3tEgJfPR
         LQ21nnWD/zFBrCII/8khCVGTUInmhT1Y+KziDPBiYOFYoIn4NUvQV2lZDayaTjKqnmHc
         pYTrDfooed39iJE0jaZY/KQ6eC0/HsEUIp96E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=V7mYhCidjz4KJqq5Af++4IzX0c+57d8UGw264x+5DzcmzIXxW1XVD2dN3vVKKMzEGq
         5cRQ2NgT/w9iK2IgNNmP/xEiC0b+QEccASDyKDBZwX6cs3d7azbtwjyyCusHs2qaTB49
         fO51t1gDmpu3PhUj1vfzJGvbc9DaUc2jk8qIw=
Received: by 10.42.76.74 with SMTP id d10mr3731889ick.362.1287908230747;
        Sun, 24 Oct 2010 01:17:10 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id 8sm6105989iba.22.2010.10.24.01.17.09
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 01:17:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101024072032.GA23455@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159838>

Jonathan Nieder wrote:

> Here's a helper to make it easier for commands that use parse-options
> to adopt that nicer behavior.  It writes its output to stdout, so it
> should only be used to be used to handle the -h option.

Alas, "git update-index" does not use parse-options yet.  But that
is easily enough changed...

Patch 1 introduces an OPTION_LOWLEVEL_CALLBACK backdoor to
parse-options, so new option types (like the three-argument type
used by update-index --cacheinfo) can be supported without tempting
inventors of other commands through mention in the public API.

Patch 2 is a toy patch I previously send to Bo.  It makes
parse_option_step() distinguish between stops due to end of options
and stops due to appearance of a nonoption; update-index benefits
from something like this because it needs to deal with filename
parameters as they appear.

Patch 3 converts update-index to parse-options.  The commit message
mentions some potential simplifications.

All three patches ought to introduce new tests, but none do.  I
hope that does not hinder reading them too much.  Thoughts?

Jonathan Nieder (3):
  parse-options: allow git commands to invent new option types
  parse-options: make resuming easier after
    PARSE_OPT_STOP_AT_NON_OPTION
  update-index: migrate to parse-options API

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  setup: save prefix (original cwd relative to toplevel) in
    startup_info

 builtin/update-index.c |  389 +++++++++++++++++++++++++++++-----------=
-------
 cache.h                |    1 +
 parse-options.c        |    9 +-
 parse-options.h        |   10 ++
 setup.c                |    4 +-
 5 files changed, 259 insertions(+), 154 deletions(-)

--=20
1.7.2.3

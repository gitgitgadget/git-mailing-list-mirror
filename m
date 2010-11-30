From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFCv2 0/6] update-index: migrate to parse-options API
Date: Mon, 29 Nov 2010 20:52:23 -0600
Message-ID: <20101130025223.GA5326@burratino>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino>
 <20101022064258.GB6081@burratino>
 <7v8w1qnkr1.fsf@alter.siamese.dyndns.org>
 <20101024072032.GA23455@burratino>
 <20101024081316.GA29630@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 03:52:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNGKj-0007VG-My
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 03:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476Ab0K3Cwg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Nov 2010 21:52:36 -0500
Received: from mail-vw0-f66.google.com ([209.85.212.66]:37825 "EHLO
	mail-vw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453Ab0K3Cwf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 21:52:35 -0500
Received: by vws15 with SMTP id 15so464762vws.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 18:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=o5ToWw0gWTenD68xQry7Fr66+paeqK3luyQJyclrJMA=;
        b=ss7eGXoaI/z5jV+uPL9EzBOh08gjUQ+umWtrt6VmwGuXHW76g7T19kcGcaGua5BwH1
         X0ZDsRaz1FkAoqg1hohhgN2Y3DireLT02IIEyoyQPswwVv/qVuCe7Ybdkw4IdLLiFsc9
         VnMYBu7aSyK5tC6vq7Rp+qOaNDw/Lz/NpnbVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Wu7NryfgEmb2g7mYms8W9Jt6Ybr+z/1io0RcAst7bylkx7ugOwsuIZ/o32geeIwdnN
         vzQ4AH6NeUHBctabWwrciYHoc0EQU0nj3xQXVeOnkxsoCrYU0R6NET3baSX1KpGgogGD
         RFWb+hjv9VD3jeLqxnzLqvpbUucahdGVzDeNs=
Received: by 10.220.191.205 with SMTP id dn13mr1685066vcb.271.1291085554401;
        Mon, 29 Nov 2010 18:52:34 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id fs21sm1854336vbb.0.2010.11.29.18.52.32
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 18:52:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101024081316.GA29630@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162463>

Here's a reroll.  Changes explained in the comments following each
patch.

Thanks to Stephen for a great deal of helpful advice.  The result
turns out to be less surgery than I thought from the version in pu,
mostly because I am trying to be conservative (meaning further
simplifications are welcome as patches on top, natch).

Based against ca20906, as before.

Jonathan Nieder (4):
  parse-options: sanity check PARSE_OPT_NOARG flag
  parse-options: allow git commands to invent new option types
  parse-options: make resuming easier after
    PARSE_OPT_STOP_AT_NON_OPTION
  update-index: migrate to parse-options API

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  setup: save prefix (original cwd relative to toplevel) in
    startup_info

Stephen Boyd (1):
  parse-options: eliminate implicit PARSE_OPT_NOARG for built-in option
    types

 builtin/update-index.c |  391 ++++++++++++++++++++++++++++++----------=
--------
 cache.h                |    1 +
 parse-options.c        |   47 ++++---
 parse-options.h        |    9 +-
 setup.c                |    4 +-
 5 files changed, 283 insertions(+), 169 deletions(-)

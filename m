X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
From: Junio C Hamano <junio@hera.kernel.org>
Subject: Re: [PATCH 1/1] Bypass expensive content comparsion during rename detection
Date: Thu, 14 Dec 2006 11:26:48 GMT
Message-ID: <200612141126.kBEBQme7021704@hera.kernel.org>
NNTP-Posting-Date: Thu, 14 Dec 2006 11:59:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 1937 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 06:59:12 EST
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34324>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GupF5-0000oM-Gq for gcvg-git@gmane.org; Thu, 14 Dec
 2006 12:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932667AbWLNL7N (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 06:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932674AbWLNL7N
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 06:59:13 -0500
Received: from hera.kernel.org ([140.211.167.34]:56634 "EHLO hera.kernel.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932667AbWLNL7M
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 06:59:12 -0500
Received: from hera.kernel.org
 (IDENT:U2FsdGVkX18QCRHAekfpXvxlQJeNMxfqlALA8CxBctA@localhost [127.0.0.1]) by
 hera.kernel.org (8.13.8/8.13.7) with ESMTP id kBEBQmxK021708
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Thu, 14
 Dec 2006 11:26:48 GMT
Received: (from junio@localhost) by hera.kernel.org (8.13.8/8.13.1/Submit) id
 kBEBQme7021704; Thu, 14 Dec 2006 11:26:48 GMT
To: <Johannes.Schindelin@gmx.de>, Johannes@hera.kernel.org,
 Schindelin@hera.kernel.org
Sender: git-owner@vger.kernel.org

estimate_similarity() is called after it has determined that one
and two do not match exactly, and it relies on populate_filespec
with at least size-only has been called on them so that it can
reject filepair with vastly different sizes, still without
looking at (thus without loading) the contents.

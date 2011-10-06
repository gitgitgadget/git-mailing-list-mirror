From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 0/7] pickaxe: plug memory leaks, deduplicate code
Date: Thu, 06 Oct 2011 17:59:33 +0200
Message-ID: <4E8DD065.3040607@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 06 17:59:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBqMQ-00045D-Lf
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 17:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965Ab1JFP7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 11:59:46 -0400
Received: from india601.server4you.de ([85.25.151.105]:56157 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964856Ab1JFP7p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 11:59:45 -0400
Received: from [192.168.2.104] (p4FFDBCAF.dip.t-dialin.net [79.253.188.175])
	by india601.server4you.de (Postfix) with ESMTPSA id AC3342F8034;
	Thu,  6 Oct 2011 17:59:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182963>

Hello,

this series aims to clean up the code for pickaxe (-S/-G).  The first
three patches plug minor to medium memory leaks.

	[PATCH 1/7] pickaxe: plug diff filespec leak with empty needle
	[PATCH 2/7] pickaxe: plug regex leak
	[PATCH 3/7] pickaxe: plug regex/kws leak

The next one moves a duplicate if/else cascade into its own helper
function:

	[PATCH 4/7] pickaxe: factor out has_changes

The remainder unifies the code for pickaxe (-S) and log grep (-G).

	[PATCH 5/7] pickaxe: pass diff_options to contains and has_changes
	[PATCH 6/7] pickaxe: give diff_grep the same signature as has_changes
	[PATCH 7/7] pickaxe: factor out pickaxe

As a result the code should be shorter and easier to maintain.

 diffcore-pickaxe.c |  178 ++++++++++++++++++++-------------------------------
 1 files changed, 70 insertions(+), 108 deletions(-)

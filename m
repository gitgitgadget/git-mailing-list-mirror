From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 0/5] do not overwrite untracked files in leading path
Date: Sat,  9 Oct 2010 15:52:55 +0200
Message-ID: <1286632380-7002-1-git-send-email-drizzd@aon.at>
References: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 15:53:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4ZrV-0003Jt-Mj
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 15:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839Ab0JINxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 09:53:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45451 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309Ab0JINxE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 09:53:04 -0400
Received: by fxm14 with SMTP id 14so952438fxm.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 06:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=rAS+gq2japJiGWYzZdmWfTwevwcbHiMYs1ddP/+zFf4=;
        b=kv0W4zQdXmpHZ3aEx8pjjiq31bWssHqyzDLrcbyw4pKnS8m1qXEnlGIaTNwUiPG4Kg
         yyfK4KCRGXBMxNEy1ynbeNenZ0mJ5eEahqYwikJbU3ZfJNF8GzBNFjacNwu2FSaMrIQr
         UtM1ECXoiE5e5V2lFQZmTwicTYavgi0n50wro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=v3nNY/Hfbz7Ze1Ngz+FFjrvUUXH0zJR48EI3iXw6D/nh7KLdUEuZkdcQPmEI8auVEn
         zFtwzW0sCRPWUKW6yY/nCHALzEMz/A2Z5MPY8InnZWqYMTBlg2oTv9XpdMccsSy2rJjr
         MIByfuTnpWI1/igRlroFJx58rPnYHDQ+9ut8c=
Received: by 10.223.73.193 with SMTP id r1mr429476faj.128.1286632382829;
        Sat, 09 Oct 2010 06:53:02 -0700 (PDT)
Received: from darc.lan (p549A51C3.dip.t-dialin.net [84.154.81.195])
        by mx.google.com with ESMTPS id 14sm2155626fav.2.2010.10.09.06.53.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 06:53:01 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1P4ZrN-0001sY-0k; Sat, 09 Oct 2010 15:53:13 +0200
X-Mailer: git-send-email 1.7.1.571.gba4d01
In-Reply-To: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158586>

Hi,

On Fri, Aug 20, 2010 at 01:35:32PM -0700, Junio C Hamano wrote:
>
>     $ echo foo >po
>     $ git checkout pu
> 
> should error out, as "po" is a directory that has tracked
> contents, and we never said the untracked regular file "po" is
> trashable, but the above sequence happily checks the branch out.

The following patch series is aimed at fixing this bug.

Clemens

[PATCH 1/5] t7607: use test_commit and test_must_fail
[PATCH 2/5] t7607: add leading-path tests
[PATCH 3/5] add function check_ok_to_remove()
[PATCH 4/5] lstat_cache: optionally return match_len
[PATCH 5/5] do not overwrite files in leading path

 cache.h                    |    2 +-
 symlinks.c                 |   64 +++++++++++++++-------
 t/t7607-merge-overwrite.sh |  129 +++++++++++++++++++++++++++++---------------
 unpack-trees.c             |  121 ++++++++++++++++++++++++-----------------
 4 files changed, 200 insertions(+), 116 deletions(-)

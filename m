From: Samuel Bronson <naesten@gmail.com>
Subject: [BUG] "echo HEAD | git cat-file --batch=''" fails catastrophically
Date: Tue, 10 Dec 2013 23:37:14 -0500
Message-ID: <CAJYzjmdHdLZaBijahepOQDJtDd_TdojT4ivNxGrcerRfEuHQEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 05:37:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqbY0-0007iG-Hk
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 05:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006Ab3LKEhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 23:37:16 -0500
Received: from mail-oa0-f52.google.com ([209.85.219.52]:46331 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab3LKEhP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 23:37:15 -0500
Received: by mail-oa0-f52.google.com with SMTP id h16so6704322oag.39
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 20:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=ZLOcrkJ/na3JD9EFXFHI51ZrJy1AzyIPCd+7U/41uiE=;
        b=xoGsOfFOm5eZsmejACQBZZ7immwGwloTOP9wGJn772Eg+FLQ07R1NxIBUFCY+tC8Gt
         5kME5nm7QAmE5XxPux75wVrP+WyseoyO6CRwbN0n2n78lULRlMpq6FVaPDVCbrzMcr0y
         GdR/VbgURMo30O1gzdyzXzQo6TH4eMlZMJGFYRf/h78xegNH1wxhuGQ5Ro5bHw4BjodV
         9+UrYFXUyI5RzWC9JyAEejxB5DqL9DJS+Ocm5Ry+wowhXudFyWRVMkDR6Yb2fnBZP/5p
         x7y9O0ibYKFb/amlesK5v6Lf4BQtEfm8R+wL2XNP7xXFPAg199g3LENkQdSDFDk3oF63
         AS4A==
X-Received: by 10.182.28.134 with SMTP id b6mr19689896obh.27.1386736634329;
 Tue, 10 Dec 2013 20:37:14 -0800 (PST)
Received: by 10.182.135.3 with HTTP; Tue, 10 Dec 2013 20:37:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239168>

Observe:

% echo HEAD | git cat-file --batch=

fatal: object fde075cb72fc0773d8e8ca93d55a35d77bb6688b changed type!?

Without the =, it works fine; with a string that has both
"%(objecttype)" and "%(objectsize)", it's fine; but when you don't
include both, it complains about one of the values that you did not
mention having changed.

jrnieder fingered v1.8.4-rc0~7^2~15 as the (likely?) culprit here.

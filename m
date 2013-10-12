From: Duy Nguyen <pclouds@gmail.com>
Subject: pack-object's try_delta fast path for v2 trees?
Date: Sat, 12 Oct 2013 10:42:17 +0700
Message-ID: <CACsJy8Behb7PW=pFjH=wpjfHjUiyCo8n_ER+KyzcBwCzpyG6pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Oct 12 05:42:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUq6O-0008JJ-Qp
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 05:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755566Ab3JLDmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 23:42:49 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:46927 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597Ab3JLDms (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 23:42:48 -0400
Received: by mail-oa0-f45.google.com with SMTP id i4so197549oah.18
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 20:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=kBDeRjsI7IkkZmd2wyzQCmYpGwXdFGrt0Ycb1OaC5Nk=;
        b=RHrKNLDCJ3E0tzjUkLK3BY/F17t4Q96xOth9bL4el91YbuRDfzNcVUHwXKGL0jqJzZ
         p0gC3chpz9CF1WxiX5AeKYLzb6aZ5Aaoh+K7J2FNz1FgV/msx6c3PGIL8N3WDEpu2sFK
         7SpNgSx+EfH+6vlsrrV5d5+2fprkMLRXezUdmUo9EsIIzChBKiFAdzedfOp/qKNAjVwh
         3I07W7giI84DDdgSivQdLNxkEPysJHf2hCt6x2a2zVTj1MddRzAyczXfxai0u5M2uYEL
         JkqqP8l9TBqrINfrDEixY72JmC4PgSwJ4U2gG0rQhh5xJq3kiw8fYseTWQJY+gG67k86
         NY5Q==
X-Received: by 10.60.96.169 with SMTP id dt9mr17082161oeb.27.1381549367841;
 Fri, 11 Oct 2013 20:42:47 -0700 (PDT)
Received: by 10.76.0.41 with HTTP; Fri, 11 Oct 2013 20:42:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235939>

Hi,

Just wondering if this has been considered and dropped before.
Currently we use try_delta() for every object including trees. But
trees are special. All tree entries must be unique and sorted. That
helps simplify diff algorithm, as demonstrated by diff_tree() and
pv4_encode_tree(). A quick and dirty test with test-delta shows that
tree_diff only needs half the time of diff_delta(). As trees account
for like half the objects in a repo, speeding up delta search might
help performance, I think.
-- 
Duy

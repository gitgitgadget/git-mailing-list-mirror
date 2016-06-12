From: Duy Nguyen <pclouds@gmail.com>
Subject: lib-httpd/apache.conf and mod_unixd.so
Date: Sun, 12 Jun 2016 17:48:42 +0700
Message-ID: <CACsJy8D8e2R9YZGGFQR-AC0OtWWYriuJoTmvtG4VuqdfPZGXeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 12 12:49:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC2xB-0007rS-82
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbcFLKtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2016 06:49:13 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:33011 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbcFLKtM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:49:12 -0400
Received: by mail-io0-f176.google.com with SMTP id d2so11892890iof.0
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=nMbWpqEfMnpZD/blcmOa4Rmslz3tUuETpfv4pvYPx9g=;
        b=zR5KvlovllSJuk4HIgWOX7uqAnnHUhej2zU+24szrKYfZlG4CF52pG0Eop9Flvha74
         6K5KjvsLrFLdLdb/d5eS46drmmzXzAXoQkEx3xoH4ijwjDGFuF2nGdy5bv+SHXtSnsRi
         LSr8s5un3ATKeRIL2/42OdJlQcaakTFZIPFQd5r+qFvlondPF281qliWdljfvzwSjiOc
         TRMoaWpIsv0cR8t6eGIrSNr2YgFjkkHzD712PcjphChQbGlebOzv3HFASrvg5YckWv4U
         Gx/+d3wCAnhhKq5EpuEXc9NMHOtNUMCIwgBgQJFl16jBK+iNOjsanbcLIyC8LDuf07cO
         OsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nMbWpqEfMnpZD/blcmOa4Rmslz3tUuETpfv4pvYPx9g=;
        b=CVfnhFjX+xUuU1yAsWIetDXcpZavLnPXH1nWMGFos2n7WeDZJ5+e6Nca3o9cQ0NtNr
         SyRiYsHGw6wVApVVly9O3z/bumBwXRXHhXcN5D2A7VxNW8udgS6bk7bFo6n+ZXm/afty
         7dBGGJNaQPhhCjoyeVXp1Gbj7L8s9b8ww6yowxtW3tqqCIoFGNZAr1EfVjXyYjM8gqSA
         XJWa9cjtbgZEoTgeeiD3mnV/ZXr+IN5DLAy96ERrv13BRNDzwLW6KEM7eMcr0Z+fjdzv
         jwlapcWsQ4dXfsN88U28wCYi43RNi4tG8en0HJa2nVw7QPJvhrf9cWurtpR8ms8KmMJY
         umVQ==
X-Gm-Message-State: ALyK8tJEuGB8K6urSE9i00WTHOs3VeJsS9CtUvy1dfz+44KC/uHn7Go8mihbrnInJ6d3lKB9/89ihW7bcP9NVw==
X-Received: by 10.107.8.220 with SMTP id h89mr15430390ioi.95.1465728551929;
 Sun, 12 Jun 2016 03:49:11 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Sun, 12 Jun 2016 03:48:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297106>

I need help from apache experts. On my system (gentoo 64bit,
apache-2.4.20), running an httpd test gives me

-- 8< --
Initialized empty Git repository in /home/pclouds/w/git/temp/t/trash
directory.t5539-fetch-http-shallow/.git/
checking prerequisite: NOT_ROOT

mkdir -p "$TRASH_DIRECTORY/prereq-test-dir" &&
(
        cd "$TRASH_DIRECTORY/prereq-test-dir" &&
        uid=$(id -u) &&
        test "$uid" != 0

)
prerequisite NOT_ROOT ok
[Sun Jun 12 10:42:19.958873 2016] [core:crit] [pid 31585] AH00136:
Server MUST relinquish startup privileges before accepting
connections.  Please ensure mod_unixd or other system security module
is loaded.
AH00016: Configuration Failed
1..0 # SKIP web server setup failed
-- 8< --

A quick search shows that loading mod_unixd.so will do (and did make
httpd run for me). Problem is, can I just update apache.conf to load
it when apache version >= 2.4? I don't know if doing that would cause
failure for other people because mod_unixd has existed since 2.2 and
people have run httpd tests fine so far...
-- 
Duy

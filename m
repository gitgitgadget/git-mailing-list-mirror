From: JP Sugarbroad <jpsugar@google.com>
Subject: git fetch origin $SHA1 doesn't work as often as it could
Date: Wed, 18 May 2016 16:20:24 -0400
Message-ID: <CAD0oC4yQzvAH=6a6Xgy6xOPoYCaO2zsDg5mDySkb6VJ6FdeeEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 22:21:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b37yL-00081h-OO
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 22:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbcERUU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 16:20:56 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:33478 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932684AbcERUUy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 16:20:54 -0400
Received: by mail-yw0-f177.google.com with SMTP id x194so60047476ywd.0
        for <git@vger.kernel.org>; Wed, 18 May 2016 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=bu61j17Fo06Hvy3lVf8sREt7fMrgMHk1TCG0vhKItZY=;
        b=QyF78WwTvuk1f2nLRk5Z26sTaPHSXwQRFrq67mtgbmmTf/HIoYZwrtTP5lxuEO6UP6
         axwdKMio88TuGT4iDwW7TeeHHxdz9AOPxGl0fLl+aMkcxY3018fX0S/JTRQlhz6oeys5
         N3pdTKTZpt8GKjEYpWrwWtM6fZhp0jGRmwJrOJnPuIc9EgX7ChdTo9iIY1PtbG0K7Zoq
         AKAZZ/0jTFYTuTbzTrcqnp9lq6ozKgfnyXj1h32qmff4Dz3Zcqe+E3LZ0g63kp5m0SWj
         I7xbRpa15hd1gsMCCqiGdNx222BJRYzOPeaiymit0yST+SODC75CJVJ3VDE/m2ziy9/+
         U7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bu61j17Fo06Hvy3lVf8sREt7fMrgMHk1TCG0vhKItZY=;
        b=Grayk3xTYD6robskeDlnCQCA84fTB6yya7yLs2RdonrRLhLeHiuZ3S09sz5c9zXMWU
         1fyI4JeICN2TrTsVnWUUbNf0+T1tMjZpgZFVerMbf0VCNd9NEX1wjjBvSovD8DQbUZZQ
         2MBmTtDAlSWjtYxIES7N3qSR8jOW6HD5XRdS1vXhXyYlDqusA9O3ee7LYJ3c7WO1hSsb
         GC0wU+4fC7C10Wo9MNtH/f1XTyuTno6KQS16FtMa6Jo0SJvVOQS/iINdZ2X6xLDpueoJ
         kaOUMr2mpB7Sh1p1kogprA/id6um5MdQRKeLHeqULeFhIMeb3y9ilifCLLxO7gxeU/Mp
         k4Xg==
X-Gm-Message-State: AOPr4FUevT9/5ixsiOuQ/bGkTmoYolDh6sbyxBdtZ3E9boqK64T2tJwXU0nIwygoU1EAvTs2VDZRsGvrVFulCf7o
X-Received: by 10.129.166.214 with SMTP id d205mr5095210ywh.323.1463602853809;
 Wed, 18 May 2016 13:20:53 -0700 (PDT)
Received: by 10.37.116.197 with HTTP; Wed, 18 May 2016 13:20:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295005>

So I'm trying to make cloning the rust repo a little easier, and I
noticed there's a new feature to `git submodule update --depth=1` --
but it doesn't work for this, even though it could.

Reason is that fetch-pack will only fetch by sha1 if the remote
specifies allow_tip/unreachable_sha1, even if the sha1 specified
matches an advertised ref.

My thought is to rework filter_refs() to match on oid if matching on
name fails. Thoughts?

- JP

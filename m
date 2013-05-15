From: Jiang Xin <worldhello.net@gmail.com>
Subject: [RFC 0/2] refactor relative_path in path.c
Date: Wed, 15 May 2013 23:18:37 +0800
Message-ID: <cover.1368630636.git.worldhello.net@gmail.com>
References: <7vvc6ldtx7.fsf@alter.siamese.dyndns.org>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 15 17:19:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcdTs-0006RY-GP
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 17:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759194Ab3EOPS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 11:18:59 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54630 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758897Ab3EOPS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 11:18:58 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq13so1472170pbb.19
        for <git@vger.kernel.org>; Wed, 15 May 2013 08:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=HgdR2QDP06FLr1rddMrqM46sDbneAghHQiQSsPYaU7A=;
        b=hZOyLocQ7uhxcMTlV2xTmGznKtdyAq+VR2SA03LYt10BZa6qHdpue9r6FS1ss487dY
         TIH6u/R9kSwTg0SB6/h8NvgOKP+hLe6VOn9n31zuw+4twKmrcOp+zbHSEGfv5clNHhAF
         0vEjr3m1fmHxOoWUfv1b06QOsTndWRVPMXNQ/W6ugfvQ1wwNzn7+bJZlurvErhp1lNAc
         P7njWcKbU6kFk4Tqgu1KGoyA7knh5bTnM3P4R0VRPn5PHEANejtd18akfgpuUZJLnQg1
         0Zn4vpv/whdevTgMGeZxXSaJeurvoxdKfUC6MzdSkTX+xTh3ByGXFPBHlFL16pgipmBn
         yufQ==
X-Received: by 10.66.149.227 with SMTP id ud3mr40486637pab.33.1368631138284;
        Wed, 15 May 2013 08:18:58 -0700 (PDT)
Received: from localhost.localdomain ([114.248.153.37])
        by mx.google.com with ESMTPSA id iy2sm3161860pbb.31.2013.05.15.08.18.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 15 May 2013 08:18:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.404.ga32c147
In-Reply-To: <7vvc6ldtx7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224414>

2013/5/15 Junio C Hamano <gitster@pobox.com>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> +/*
>> + * Give path as relative to prefix.
>> + *
>> + * This function is a combination of path_relative (in quote.c) and
>> + * relative_path (in path.c)
>> + */
>> +static const char *path_relative(const char *in, const char *prefix)
>> +{
>> +...
>
> Hmph.  Is it possible to reuse the public one (in path.c) here and
> in quote.c, perhaps after enhancing it a bit to serve needs of the
> callers of two existing ones and the new callers of this one?
>

These two patches enhance relative_path() in path.c, so that function
relative_path() will return real relative path, not a path strip off
the prefix.

The 2nd patch is a bit aggressive, it refactor all related functions,
remove unnecessary arguments: len and/or prefix_len.

Please review them. They will be prerequisites for the interactive
git-clean patch series.

Jiang Xin (2):
  path.c: refactor relative_path(), not only strip prefix
  quote.c: remove path_relative, use relative_path instead

 builtin/clean.c    | 18 +++++------
 builtin/grep.c     |  4 +--
 builtin/ls-files.c | 13 ++++----
 path.c             | 94 ++++++++++++++++++++++++++++++++++++++++++------------
 quote.c            | 71 +++--------------------------------------
 quote.h            |  7 ++--
 wt-status.c        | 17 +++++-----
 7 files changed, 107 insertions(+), 117 deletions(-)

-- 
1.8.3.rc1.404.ga32c147

From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2] xdiff/xprepare: improve O(n*m) performance in xdl_cleanup_records()
Date: Wed, 17 Aug 2011 23:55:32 +0800
Message-ID: <CALUzUxovdmhnRKPaEq01-q0pvez91s_Z_rHWg-FkwcU0VD3HQQ@mail.gmail.com>
References: <7vd3g5i7ci.fsf@alter.siamese.dyndns.org>
	<1313546037-4104-1-git-send-email-rctay89@gmail.com>
	<20110817052147.GA11253@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 17 17:55:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtiSx-000295-8p
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 17:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987Ab1HQPze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 11:55:34 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46332 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790Ab1HQPzd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 11:55:33 -0400
Received: by fxh19 with SMTP id 19so725098fxh.19
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 08:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HdJyVVQP+vX1onw0WqlI9omQ8IJIsaImh3wamnh9x+c=;
        b=WRyIQqezwWj/lqw1Jtrdoi1H5tddVJjgJ5q5xtbTRswG05rtfQwXAJQgkwXgyC6gBo
         Rtx2OzTd6WeY1JeOodplmE0pWkVDx8BWiXJNApOeuwj9ui6w4PMHww6F9IdZVSNYDeZN
         0nv4ON/KP96xa1BTucCpWtrDP70WHxzQtoSVA=
Received: by 10.223.8.197 with SMTP id i5mr1620958fai.67.1313596532124; Wed,
 17 Aug 2011 08:55:32 -0700 (PDT)
Received: by 10.223.95.198 with HTTP; Wed, 17 Aug 2011 08:55:32 -0700 (PDT)
In-Reply-To: <20110817052147.GA11253@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179518>

On Wed, Aug 17, 2011 at 1:21 PM, Jeff King <peff@peff.net> wrote:
> Wait, what? It was using 0 seconds of user time before, but still taking
> 8.5 seconds? What was it doing? Did you actually warm up your disk cache
> before taking these measurements?

Three runs on the same machine, after a restart.

  $ time git show >/dev/null

  real    0m6.505s
  user    0m0.031s
  sys     0m0.015s

  rctay@TEST-123 /tmp/slono
  $ time git show >/dev/null

  real    0m5.429s
  user    0m0.000s
  sys     0m0.031s

  rctay@TEST-123 /tmp/slono
  $ time git show >/dev/null

  real    0m5.336s
  user    0m0.000s
  sys     0m0.016s

-- 
Cheers,
Ray Chuan

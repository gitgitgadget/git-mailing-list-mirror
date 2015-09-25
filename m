From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] Makefile: link libcurl before openssl and crypto
Date: Thu, 24 Sep 2015 17:15:58 -0700
Message-ID: <xmqqmvwbuzep.fsf@gitster.mtv.corp.google.com>
References: <1443116590-6222-1-git-send-email-repk@triplefau.lt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Remi Pommarel <repk@triplefau.lt>
X-From: git-owner@vger.kernel.org Fri Sep 25 02:16:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfGgZ-0004Kn-Fq
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 02:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbbIYAQC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 20:16:02 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33092 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbbIYAQA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 20:16:00 -0400
Received: by pacex6 with SMTP id ex6so87274621pac.0
        for <git@vger.kernel.org>; Thu, 24 Sep 2015 17:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gQjtFoVYgkwqDwE/akUbt/wWtIXplsVR6sUleTmMQPQ=;
        b=cyvDG2iQiCNMVX08HaW9zlA2GtA6VdLXTwyTluHjh4y0YO2hiynSHK9/H8oEELbgUa
         esSp+LUPd6i7HNmdB3P3EgupqxcRStQAQ+jszlTzdoUpN7/YYVC7ndeHXa/Sf/ZA4B1a
         ucGwiTgDyb+EYTw8P9lI63og/maugUEWMFNz3wb/O9U2JcjWw7LDL+73RImS5U4Vv2Ic
         rYETZ1yTB6LmQFayE6YLaYCoCW8rFd4gcRJIU7UAkuyTv4pKJof9HNmJi7k9AtPdo15N
         N3CxKgDOYxMzI2YScpoEN8Nz3NkEZMUOSK7G4d+QSYIMZe8MdEcbUWG9n5HUAOYapF7D
         aVzQ==
X-Received: by 10.66.139.133 with SMTP id qy5mr3188871pab.44.1443140159714;
        Thu, 24 Sep 2015 17:15:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:9c11:78a0:634d:a891])
        by smtp.gmail.com with ESMTPSA id ok4sm559850pbb.65.2015.09.24.17.15.58
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 24 Sep 2015 17:15:58 -0700 (PDT)
In-Reply-To: <1443116590-6222-1-git-send-email-repk@triplefau.lt> (Remi
	Pommarel's message of "Thu, 24 Sep 2015 19:43:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278638>

Remi Pommarel <repk@triplefau.lt> writes:

> For static linking especially library order while linking is important. For
> example libssl contains symbol from libcrypto so the former should be linked
> before the latter.

That example is not a very good one to use for two reasons:

 (1) NEEDS_SSL_WITH_CRYPTO is a conter-example of crypto wanting to
     be before the latter.

 (2) More importantly, you are not changing the order between them.

The breakage you are fixing with this patch is that libcurl want to
come before libssl when building http-push, http-fetch, and remote-curl,
so that is a very good example to use in the above sentence.

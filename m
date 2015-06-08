From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] am: teach StGit patch parser how to read from stdin
Date: Mon, 08 Jun 2015 12:57:58 -0700
Message-ID: <xmqqh9qi9dmh.fsf@gitster.dls.corp.google.com>
References: <1433778531-18260-1-git-send-email-pyokagan@gmail.com>
	<1433778531-18260-3-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Chris Packham <judge.packham@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 21:58:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z23BX-0002ds-9d
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 21:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639AbbFHT6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 15:58:08 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34693 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636AbbFHT6A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 15:58:00 -0400
Received: by iebmu5 with SMTP id mu5so670297ieb.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 12:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5C73yxIOWA7FmdZ2duvr17wy31wdkMXUa5+bQcMAwK8=;
        b=mjz8G85JAnntnPwPKLfaOad6UIVwXRqIwwd/+wP0E74FzLr/rghPvJHxhis59pahX/
         kbn1HbksAo8aAi+mlKTdTxOJgK+2npnAxwtnrCiE9+WenpKVy7jh03xi82Z6Ufq54T/b
         ao9RJ5ClIDMIc/4gJJrU27aQWB/YMd7Zs9KQntzFk7RuLvBm+WxMXdEYwLsp2UQudxUu
         yKmkdTskYBAX/LhWqsKFlwtmZu+7Y3po4sHn09jsoJ9D7dm0tAMicuDhJ0CGauSNyfcn
         XDhm37KGRVrfDeTL5H2YItfu6/FcoqIGmSDVfkRovnNcbRLK0csn6ZAJ4xLb+8iPhrSd
         HH8Q==
X-Received: by 10.43.148.72 with SMTP id kf8mr25987000icc.76.1433793480246;
        Mon, 08 Jun 2015 12:58:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id j5sm2408710ioo.8.2015.06.08.12.57.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 12:57:59 -0700 (PDT)
In-Reply-To: <1433778531-18260-3-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Mon, 8 Jun 2015 23:48:48 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271119>

Paul Tan <pyokagan@gmail.com> writes:

> git-mailsplit, which splits mbox patches, will read the patch from stdin
> when the filename is "-" or there are no files listed on the
> command-line.
>
> To be consistent with this behavior, teach the StGit patch parser to
> read from stdin if the filename is "-" or no files are listed on the
> command-line.

Hmm, doesn't

	perl -ne 'processing for each line'

with or without a BEGIN {} block, read from the standard input (if
no filename is given) or the given file (if given), and more
importantly, doesn't it treat a lone "-" as STDIN anyway?

That is, wouldn't it make more sense to do something like:

	test $# != 0 || set -- -
        for stgit
        do
        	...
                @@PERL@@ -ne 'BEGIN { $subject = 0 }
                	...
		' "$stgit" >"$dotest/$msgnum" || clean_abort
	done

Same for patch 5/5.

Other than that, the entire series looked great from a cursory read.

Thanks.

From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 0/6] pseudorefs
Date: Tue, 28 Jul 2015 14:12:18 -0400
Message-ID: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
Cc: mhagger@alum.mit.edu, sunshine@sunshineco.com, philipoakley@iee.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 20:12:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK9Mu-0004hL-1m
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 20:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbbG1SMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 14:12:43 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:34187 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbbG1SMm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 14:12:42 -0400
Received: by qgeu79 with SMTP id u79so80266206qge.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 11:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B+cpLaBpXlfOn9J2cTR8Fohh5wFykU/YNw9HY5r4hyM=;
        b=kehhOvQhMmW2pD+LZkkfih4Qqghg7LzPBWJLtqGL9isc5snR63XWerMgMkB9ZtjgsK
         xRj+e84JnFx1VyO04HJcCyjNN7vSAzoFcxDU+kw1kR/5FJqrjH1wBJM1tElfxeQKOCjc
         o16BrM34t5iMVooKwc9HulxJWLeqvh4KVgCbXIMmhfNe1umWTO9UAnrAea3jCeivJz/l
         DAz3w1cToItac8WmJbkwo/ZhrEYK0TuBvEmuzAdOoFVH0EV1Lw8cjH6di16TYaEdRWVA
         0p+pGeZkegLhKYzt9Ac+0ychVKGScHeL2OlTpuhN8xvpi+HC+AVlV6IA1f8ackiR0bK5
         W+pA==
X-Gm-Message-State: ALoCoQk0LjcujHF76Jjv7HwBzVv8UBnAB3m2QY2d6j86ws8wKEbYpbi36u3tCYNcnZNn0NW+/hQB
X-Received: by 10.140.33.21 with SMTP id i21mr50681610qgi.4.1438107161661;
        Tue, 28 Jul 2015 11:12:41 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 34sm11653540qkz.38.2015.07.28.11.12.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jul 2015 11:12:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274803>

This version fixes documentation issues found by Eric Sunshine.

It also adds a new patch so as not to create static functions that
aren't immediately used; Eric also noticed that issue.

I refactored the functions to classify a ref into a single public
ref_type function.  This makes it easy for backends that want to treat
all non-normal refs the same; in previous patch versions, backends
would have had to say is_pseudoref || is_per_worktree_ref, and that
would have caused the strcmp in is_per_worktree_ref to be called
twice.  Now they can just say ref_type(ref) != REF_TYPE_NORMAL.

I also fixed another issues that I noticed myself: I removed a stray
debugging "&& 0" condition.

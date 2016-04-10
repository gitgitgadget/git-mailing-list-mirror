From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 07/21] bisect: plug the biggest memory leak
Date: Sun, 10 Apr 2016 15:19:00 +0200
Message-ID: <1460294354-7031-8-git-send-email-s-beyer@gmx.net>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:21:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFJ3-0000h0-Pj
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbcDJNVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:21:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:53299 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753215AbcDJNUH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:20:07 -0400
Received: from fermat.fritz.box ([92.76.224.62]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0LlpJU-1bOa6E3BtQ-00ZMLi; Sun, 10 Apr 2016 15:20:02
 +0200
X-Mailer: git-send-email 2.8.1.137.g522756c
In-Reply-To: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:VR7FDwHyKsSc4RoMoPsQSum7c1HLEPg3U5/gnVZqWdXgwHJmBJJ
 6jE6No+SHuB0XSvAE+Qo3OdqVJa0VgtN6rJRJxzrDldp3U0H6lGjBgmRpPcJLkccXetIhWm
 FlyXFzyoPft8N2IaqjvhSGm9vwK9uZUtThue1QH98frkbIk1wzLvU75HzouZKHzS7W1X1HR
 ASSezlrmOC2vadbS/NyLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AVOE8DgDdnM=:VpzapOUCQPdJVIZegpc9r3
 WdTg4uy+Vek5XnRQN4AZRk2tXRCHaW9OAU3EmpGhKNaodPAPfAos0RQdyJbu+nyx319666Qs+
 c4LEfyfW35qvgIGiWdLmwvVa8qX+Vp96thctAbehDd9HZ90p2NBHkDzsYNmaSlrcu0OlLB7VH
 A+EKoIeDv+Y3RemQfvhl7K7GSP7l4o5QlEnQ3e3nEnuX9TF7XmCeCY6TtB+W7W3RQLiqN4hi5
 CLj74knidHN3SNAwrHeE8ExahfV9cDwCrBj8EFZOQaCr8heDGZrQQWswKCiVQlc71Pn7Kz7Aq
 hXbNPfjiviWmqJR/mvgII2a9AnLkuY4T10XtnX/mhrl/7wNoHdCmmN6bOX/LUVf+43+KsHbgg
 sISWqWsFTdAHolMLOPS1RB647X5b13rbWnU1T7NW/m1htzXRf1rP5B8M7m8REH7sHctZ61Diz
 Z3rbzvdAawtKpSL+7Ljum6vIlH9VaEKdyhy29HK+ufKgRxI3qEwt7+VYzrugi8WOFM1vqyRSV
 ohHpbyftKf+jyI4H4w1s9+J52eHd+gaxRGy0pdaPQyQNNk0n24tvulyCoZaSU9HEuw58dEMNZ
 IpdNbi6ZlEdsu+q2rKU4VjRKUilLIj0qRcUGzZFetYNfcMAoClpH18JnXKSp89GivYrfH5qp+
 0Z0dSzfPksyDHQlR+hu3jRclNhhQIpl4NMzC8C6rP1Y3S4FSpeZtXro4k+vxSqKhPVKQ61lWx
 PBD/YdxaJ+imS7WsKGiog91KVom8jDVbpUTZQvKZogPy4yopdjIZoq+xaI4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291164>

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 bisect.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bisect.c b/bisect.c
index 7996c29..901e4d3 100644
--- a/bisect.c
+++ b/bisect.c
@@ -984,6 +984,8 @@ int bisect_next_all(const char *prefix, int no_checkout)
 		exit(10);
 	}
 
+	free_commit_list(revs.commits);
+
 	nr = all - reaches - 1;
 	steps = estimate_bisect_steps(all);
 	printf("Bisecting: %d revision%s left to test after this "
-- 
2.8.1.137.g522756c

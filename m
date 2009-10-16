From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Generalized "string function" syntax
Date: Fri, 16 Oct 2009 01:28:19 -0700
Message-ID: <1255681702-5215-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 10:33:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyiFh-0000yJ-Nc
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 10:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756737AbZJPI3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 04:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757182AbZJPI3J
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 04:29:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34959 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755595AbZJPI3I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 04:29:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0882C79890
	for <git@vger.kernel.org>; Fri, 16 Oct 2009 04:28:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=d0B75CZC0CCwHQXX4Gin9Xmk7D8
	=; b=j+EUYDq5wAAttgElJT5Zn8lWwomp6YbfXXs5pD8FmOhb6HlBoUX5+qi0YJf
	Ri3Q/xieeQQd7rOXbZVdSCSG5FUfuNHjmxvGbhfVrHRABhrkku2b7oB2G4Nu5C9s
	5mybgMRrKf0baQ2EPRe2I1XUZpjrf3Z1/0O1EnyipZqbQJrM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=MX2nOf6DqXmlLP595E7Y7UWdU+RRk
	VPzsMSEx+EkcOJijy4KxTLTOo2xtzySCBY35FozHVgy63VZOPyF8B0ltsZD0Ccwb
	aqoQmxKaK2bxGfKam2tsSeABbglJKFykLbaNhhrdpnYylI1NBiMjjov2VGexNb1n
	23q9Rlo9phZcjs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 05D237988F
	for <git@vger.kernel.org>; Fri, 16 Oct 2009 04:28:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 829387988D for
 <git@vger.kernel.org>; Fri, 16 Oct 2009 04:28:24 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.99.g9ed7e
X-Pobox-Relay-ID: DF44EA6A-BA2D-11DE-99DB-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130465>

I mentioned an idea to enhance the pretty=format language with a string
function syntax that people can extend by adding new functions in one of
the "What's cooking" messages earlier.  The general syntax would be like

    %[function(args...)any string here%]

where "any string here" part would have the usual pretty=format strings.
E.g.  git show -s --format='%{w(72,8,4)%s%+b%]' should give you a line
wrapped commit log message if w(width,in1,in2) is such a function.

This series is a proof of concept, as I didn't actually plug the
"wrapping" code into it; it would be fairly straightforward to integrate
the logic Dscho made strbuf capable in js/log-wrap series (queued in 'pu')
to finish this.

Junio C Hamano (3):
  format_commit_message(): fix function signature
  strbuf_nested_expand(): allow expansion to interrupt in the middle
  Add proof-of-concept %[w(width,in1,in2)<<any-string>>%]
    implementation

 commit.h |    2 +-
 pretty.c |   86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 strbuf.c |   23 +++++++++++++---
 strbuf.h |    3 +-
 4 files changed, 107 insertions(+), 7 deletions(-)

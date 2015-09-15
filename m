From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] doc: show usage of branch description
Date: Tue, 15 Sep 2015 17:06:27 +0100
Organization: OPDS
Message-ID: <9075C82973D34EABBB96023B75D6848E@PhilipOakley>
References: <74514591d4cd502eee06cde3e099e656@dscho.org><1442098288-3316-1-git-send-email-philipoakley@iee.org><CA+P7+xqh0e+2aMZf8i-1hBc0fMgaz0UjVdboLv+L9+rBYBR85w@mail.gmail.com><DDA818BA5B3749C8953193DEC3682293@PhilipOakley> <xmqqh9mxx7fk.fsf@gitster.mtv.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Jacob Keller" <jacob.keller@gmail.com>,
	"GitList" <git@vger.kernel.org>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 21:08:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbvb1-00036m-0g
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 21:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbbIOTIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 15:08:44 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:36608 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751722AbbIOTIn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2015 15:08:43 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CEDAA2bPhVPALNYAJdGQEBHIJsgT2GWW29fwQEAoFDTQEBAQEBAQcBAQEBQSQbhB4GAQEECAEBExseAQEhCwIDBQIBAxUMJRQBBBoGBwMUBhMIAgECAwGIIbx4jW+Gc4R9hDsBAVCDH4EUBYx4OYgrAYEajTWVTYNsgi2COD0ziGuBPwEBAQ
X-IPAS-Result: A2CEDAA2bPhVPALNYAJdGQEBHIJsgT2GWW29fwQEAoFDTQEBAQEBAQcBAQEBQSQbhB4GAQEECAEBExseAQEhCwIDBQIBAxUMJRQBBBoGBwMUBhMIAgECAwGIIbx4jW+Gc4R9hDsBAVCDH4EUBYx4OYgrAYEajTWVTYNsgi2COD0ziGuBPwEBAQ
X-IronPort-AV: E=Sophos;i="5.17,536,1437433200"; 
   d="scan'208";a="559202343"
Received: from host-2-96-205-2.as13285.net (HELO PhilipOakley) ([2.96.205.2])
  by out1.ip03ir2.opaltelecom.net with SMTP; 15 Sep 2015 20:08:41 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277980>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> It still means that my patch is incomplete in its aim to bring out
>> these possible broader usages.
>>
>> I haven't yet looked at the mail archives to see if there is more
>> around the time of those introductions.
>
> I guess this is largely my fault, but I think "git grep" is an
> easier source of truth to work with than the list archive.
>
> It eventually boils down to branch.*.description configuration and
> all users of that would call read_branch_desc(), so if you check
> callers of that helper function and see which commit introduced that
> call for what purpose ("blame" is your friend), you would know how
> they use the information under what condition.
>
>
> $ git grep -n read_branch_desc -- \*.c
> branch.c:143:int read_branch_desc(struct strbuf *buf, const char
> *branch_name)
> builtin/branch.c:771:   read_branch_desc(&buf, branch_name);
> builtin/fmt-merge-msg.c:211:    if (!read_branch_desc(&desc, name)) {
> builtin/log.c:888:      read_branch_desc(&desc, branch_name);
>
> $ git blame -L210,212 -s builtin/fmt-merge-msg.c
> 898eacd8 210)
> 898eacd8 211)   if (!read_branch_desc(&desc, name)) {
> 898eacd8 212)           const char *bp = desc.buf;
>
> $ git show -s 898eacd8
> commit 898eacd8ada2d012f977948350ed60845e238037
> Author: Junio C Hamano <gitster@pobox.com>
[...]>
>    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> etc. etc.

---
Thanks.
That was very useful seeing a few more of the options in combination.
That, combined with the updated G4W, is a lot better/faster.

I've also searched for:
$ git grep -n "\.description" -- \*.sh

which only came up with
git-request-pull.sh:74: ! git config "branch.$branch_name.description" 
 >/dev/null
git-request-pull.sh:156: git config "branch.$branch_name.description"

as relevant hits:

Sometimes one can be a bit feart to try out some command options..

Philip

From: Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH v2] git-config: document interactive.singlekey requires
 Term::ReadKey
Date: Mon, 3 Mar 2014 22:15:50 +0100
Message-ID: <20140303211549.GA24857@ruderich.org>
References: <6157736903dbcb3359eda07eff6f0faf832ef256.1393790234.git.simon@ruderich.org>
 <xmqq1tyjqfbh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 22:16:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKaDd-0006Wt-9j
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 22:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341AbaCCVQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 16:16:01 -0500
Received: from zucker.schokokeks.org ([178.63.68.96]:33862 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755335AbaCCVP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 16:15:59 -0500
Received: from localhost (pD9F549CD.dip0.t-ipconnect.de [::ffff:217.245.73.205])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Mon, 03 Mar 2014 22:15:52 +0100
  id 000000000002008B.000000005314F108.00005247
Content-Disposition: inline
In-Reply-To: <xmqq1tyjqfbh.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243270>

Most distributions don't require Term::ReadKey as dependency, leaving
the user to wonder why the setting doesn't work.

Signed-off-by: Simon Ruderich <simon@ruderich.org>
---

On Mon, Mar 03, 2014 at 10:58:58AM -0800, Junio C Hamano wrote:
> Thanks, but is it true that interactive.singlekey "requries"
> Term::ReadKey?

Yes, it requires it. The code also works fine without
Term::ReadKey, but the feature "singlekey" requires this module.
I assumed a user enabling this option would also want to use the
feature, therefore "requires" is fine IMHO.

> The implementation of prompt_single_character sub wants to use
> ReadKey, but can still let the user interact with the program by
> falling back to a cooked input when it is not available, so perhaps
> a better fix might be something like this:
>
>         if (!$use_readkey) {
>         	print STDERR "missing Term::ReadKey, disabling interactive.singlekey\n";
>         }
>
> inside the above if() that prepares $use_readkey?

Good idea. Implemented in an additional patch.

I think the documentation should also be updated (this patch) to
make it clear to a reader of the man page, that an additional
module is required, without having him to try to use the option.

> You also misspelled the package name it seems ;-)

Oops, sorry. Fixed in this reroll.

Regards
Simon

 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5f4d793..406a582 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1633,7 +1633,7 @@ interactive.singlekey::
 	linkgit:git-add[1], linkgit:git-checkout[1], linkgit:git-commit[1],
 	linkgit:git-reset[1], and linkgit:git-stash[1]. Note that this
 	setting is silently ignored if portable keystroke input
-	is not available.
+	is not available; requires the Perl module Term::ReadKey.
 
 log.abbrevCommit::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
-- 
1.9.0.11.g9a08b42

-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

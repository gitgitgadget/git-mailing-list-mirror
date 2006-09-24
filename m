From: David Rientjes <rientjes@cs.washington.edu>
Subject: Re: [PATCH 1/2] use SHA_DIGEST_LENGTH
Date: Sat, 23 Sep 2006 20:33:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64N.0609232028290.14996@attu4.cs.washington.edu>
References: <Pine.LNX.4.64N.0609232011050.14284@attu4.cs.washington.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Sep 24 05:33:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRKkS-0007eI-4Z
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 05:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbWIXDdg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 23:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752078AbWIXDdg
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 23:33:36 -0400
Received: from mx4.cs.washington.edu ([128.208.4.190]:61149 "EHLO
	mx4.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1752077AbWIXDdg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 23:33:36 -0400
Received: from attu4.cs.washington.edu (attu4.cs.washington.edu [128.208.1.140])
	by mx4.cs.washington.edu (8.13.7/8.13.7/1.6) with ESMTP id k8O3XZVm026638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sat, 23 Sep 2006 20:33:35 -0700
	(envelope-from rientjes@cs.washington.edu)
Received: from localhost (rientjes@localhost)
	by attu4.cs.washington.edu (8.13.7/8.13.7/Submit/1.2) with ESMTP id k8O3XZYm015230
	for <git@vger.kernel.org>; Sat, 23 Sep 2006 20:33:35 -0700
	(envelope-from rientjes@cs.washington.edu)
X-Authentication-Warning: attu4.cs.washington.edu: rientjes owned process doing -bs
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64N.0609232011050.14284@attu4.cs.washington.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27645>

On Sat, 23 Sep 2006, David Rientjes wrote:

> @@ -202,16 +202,17 @@ int cmd_name_rev(int argc, const char **
>  #define ishex(x) (isdigit((x)) || ((x) >= 'a' && (x) <= 'f'))
>  				if (!ishex(*p))
>  					forty = 0;
> -				else if (++forty == 40 &&
> +				else if (++forty == 2 * SHA_DIGEST_LENGTH &&
>  						!ishex(*(p+1))) {
> -					unsigned char sha1[40];
> +					unsigned char sha1[2 * SHA_DIGEST_LENGTH];
>  					const char *name = "undefined";
>  					char c = *(p+1);
>  
>  					forty = 0;
>  
>  					*(p+1) = 0;
> -					if (!get_sha1(p - 39, sha1)) {
> +					if (!get_sha1(p - (SHA_DIGEST_LENGTH + 1),
> +						      sha1)) {
>  						struct object *o =
>  							lookup_object(sha1);
>  						if (o)

Off by 18 error.

Signed-off-by: David Rientjes <rientjes@cs.washington.edu>
---
 builtin-name-rev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index f522664..ed99679 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -211,7 +211,7 @@ #define ishex(x) (isdigit((x)) || ((x) >
 					forty = 0;
 
 					*(p+1) = 0;
-					if (!get_sha1(p - (SHA_DIGEST_LENGTH + 1),
+					if (!get_sha1(p - 2 * SHA_DIGEST_LENGTH + 1,
 						      sha1)) {
 						struct object *o =
 							lookup_object(sha1);

From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/3] add 'git credential' plumbing command
Date: Sun, 24 Jun 2012 13:37:43 +0200
Message-ID: <vpqr4t5j5yw.fsf@bauges.imag.fr>
References: <1340381231-9522-1-git-send-email-Matthieu.Moy@imag.fr>
	<1340381231-9522-2-git-send-email-Matthieu.Moy@imag.fr>
	<7vzk7vnlhq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Javier.Roucher-Iglesias@ensimag.imag.fr,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	Kim Thuat Nguyen <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 13:38:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sil9R-0006Zh-7e
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 13:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434Ab2FXLh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jun 2012 07:37:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41642 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754027Ab2FXLh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2012 07:37:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5OBbAZf014459
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 24 Jun 2012 13:37:10 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sil8S-0006Mi-MD; Sun, 24 Jun 2012 13:37:44 +0200
In-Reply-To: <7vzk7vnlhq.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 22 Jun 2012 13:24:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 24 Jun 2012 13:37:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5OBbAZf014459
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1341142631.27283@h6iKlA10ZVuCPbiFTp3HCQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200521>

[ Ccing Peff. I should have done it when sending the patch ]

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> From: Javier Roucher Iglesias <Javier.Roucher-Iglesias@ensimag.imag.fr>
>>
>> The credential API is in C, and not available to scripting languages.
>> Expose the functionalities of the API by wrapping them into a new
>> plumbing command "git credentials".
>>
>> In other words, replace the internal "test-credential" by an official Git
>> command.
>>
>> Most documentation writen by: Jeff King <peff@peff.net>
>> Signed-off-by: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
>> Signed-off-by: Kim Thuat Nguyen <Kim-Thuat.Nguyen@ensimag.imag.fr>
>> Signed-off-by: Javier Roucher Iglesias <Javier.Roucher-Iglesias@ensimag.imag.fr>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>>  .gitignore                                  |   2 +-
>>  Documentation/git-credential.txt            | 126 ++++++++++++++++++++++++++++
>>  Documentation/technical/api-credentials.txt |  39 +--------
>>  Makefile                                    |   2 +-
>>  builtin.h                                   |   1 +
>>  test-credential.c => builtin/credential.c   |  20 ++---
>
> Nice ;-)
>
>> diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
>> new file mode 100644
>> index 0000000..b64ac30
>> --- /dev/null
>> +++ b/Documentation/git-credential.txt
>> @@ -0,0 +1,126 @@
>> ...
>> +DESCRIPTION
>> +-----------
>> +...
>
> Very clearly written.

... Thanks to Peff ;-).

>> +TYPICAL WORKFLOW
>> +----------------
>> +
>> +An application using git-credential will typically follow this
>> +workflow:
>
> Again, who does what in what order is very clearly described below.
>
> One minor question I had was "is this _workflow_?".  "An application
> using ... typically follow this workflow:" might want to be reworded
> to "An application uses `git credential` like this:" or something like
> that.

I made that "will typically use `git credential` following these steps:

> I am not sure about the section title, though.

I changed it to "TYPICAL USE OF GIT CREDENTIAL".

>> +  1. Generate a credential description based on the context.
>> ++
>> +For example, if we want a password for
>> +`https://example.com/foo.git`, we might generate the following
>> +credential description (don't forget the blank line at the end):
>
> Add "; it tells `git credential` that the application finished feeding
> all the infomation it has" or something after "blank line at the
> end" to justify why the user must not forget it.

Done.

>> +
>> +         protocol=https
>> +         host=example.com
>> +         path=foo.git
>
> I also thought that we discussed optionally removing the burden of
> parsing the incoming URL (e.g. https://exmaple.com/foo.git) into its
> components by giving them a way to feed a single line
>
> 	url=https://example.com/foo.git
>
> in place of the above three?  Perhaps it will come as an enhancement
> in a later patch in the series?

Not in this serie. The conclusion was that it would be easy to add
afterwards if needed. Actually, I think it would make sense to add a new
command "git credential parse-url" or so, that would read a credential
description on stdin and output its canonical form on stdin. That would
allow

$ echo 'http://foo.com' | git credential parse-url
protocol=http
host=foo.com
...

and that would allow the caller to sort-of call credential_from_url
(in credential.c) from another language.

>> +  2. Ask git-credential to give us a username and password for this
>> +     description. This is done by running `git credential fill`,
>> +     feeding the description from step (1) to its stdin. The username
>> +     and password will be produced on stdout, like:
>> +
>> +	username=bob
>> +	password=secr3t
>
> I may be ahead of myself, but the following untold paragraph came to
> my mind while I was reading this:
>
>     If the "git credential" knew about the password, this step may
>     not have involved the user actually typing this password (the
>     user may have typed a password to unlock the keychain instead,
>     or no user interaction was done if the keychain was already
>     unlocked) before it returned "password=secr3t".

Added.

>> +  3. Try to use the credential (e.g., by accessing the URL with the
>> +     username and password from step (2)).
>
> OK.  Drop "Try to use" and just say "Use"; it's clearer.  Similarly,
> s/by accessing/access/.

I took that, but added "and see if it's accepted." at the end of the
sentense to insist on the fact that "git credential" is not the one who
knows whether the authentication failed or not.

>> +  4. Report on the success or failure of the password. If the
>> +     credential allowed the operation to complete successfully, then
>> +     it can be marked with an "approve" action. If the credential was
>> +     rejected during the operation, use the "reject" action. In either
>> +     case, `git credential` should be fed with the credential
>> +     description obtained from step (2) together with the ones already
>> +     provided in step (1).
>
> A question that came to my mind after the first sentence was "Why
> should I report it?  What benefit am I getting, if I successfully
> accessed the resource I wanted to in the previous step already?"
>
>     4. Tell the git credential if the credential was good, so that
>        git credential can ask the user the correct password upon the
>        next invocation, if the one returned in step 2. did not work
>        (e.g. a bad password came from a keychain), by using "approve"
>        to tell it that it was good, or "reject" to tell it that it
>        was bad.  In either case, ...

I like the idea, but I think your wording has an overly long sentence. I
grabbed some pieces and inserted them into the existing paragraph.

> The term "credential" is used here without definition (I think you
> meant a <username, password> pair with the word).  I think it makes
> the description shorter to say "credential" instead of "username and
> password", but then we would want to define the term upfront and use
> it throughout the document.  E.g. the end of step 2. would read like
> this if we did so:
>
> 	... to its standard input.  The credential will be produced
> 	on the standard output, like so:
>
> 		username=bob
>                 password=secr3t
>
> Oh, another thing.  Please avoid using "stdin", etc., when you are
> not discussing variables in the program text but you are referring
> to them as mechanism names, and instead spell it out.

Done, but the next patch is changing that to "The complete credential
description" anyway. There's a little ambiguity between "credential" ==
<username,password> and "credential description" == struct credential ==
the whole set of attributes, so patch 2 does now

     The complete credential description (including the credential per
     se, i.e. the login and password) will be produced on standard
     output

>> +[[IOFMT]]
>> +INPUT/OUTPUT FORMAT
>> +-------------------
>> +
>> +`git credential` reads and/or writes (depending on the action used)
>> +credential information in its standard input/output. These information
>> +can correspond either to keys from which `git credential` will obtain
>> +the login/password information (e.g. host, protocol, path), or to the
>> +actual credential data to be obtained (login/password).
>
> Shouldn't "keys from which ..." be "keys for which ..."?  You ask
> for a data item from somebody who has the data _for_ a key, or you
> query a data item from a database _with_ a key.  The data source
> could be human in this context, so I'd prefer not get my brain
> queried with a key (asking me politely for data for a key is OK ;-).

I guess your english is better than mine, so I take this ;-).

>> diff --git a/test-credential.c b/builtin/credential.c
>> similarity index 63%
>> rename from test-credential.c
>> rename to builtin/credential.c
>> index dee200e..4147314 100644
>> --- a/test-credential.c
>> +++ b/builtin/credential.c
>> @@ -1,21 +1,18 @@
>> -#include "cache.h"
>> +#include <stdio.h>
>>  #include "credential.h"
>> -#include "string-list.h"
>> +#include "builtin.h"
>
> I understand that you do not want the entire cache.h, but could you
> include "git-compat-util.h" instead?  We try to absorb platform
> dependencies in that header file and avoid including system headers
> directly to C sources.

Done.

>>  static const char usage_msg[] =
>> -"test-credential <fill|approve|reject> [helper...]";
>> +	"credential <fill|approve|reject>";
>>  
>> -int main(int argc, const char **argv)
>> +int cmd_credential (int argc, const char **argv, const char *prefix)
>
> Style.

Removed space before "(".

In summary, I'm squashing this into the patch:

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index b64ac30..d5228a3 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -44,17 +44,19 @@ credential matching the description.
 
 If the action is `approve` or `reject`, no output should be emitted.
 
-TYPICAL WORKFLOW
-----------------
+TYPICAL USE OF GIT CREDENTIAL
+-----------------------------
 
-An application using git-credential will typically follow this
-workflow:
+An application using git-credential will typically use `git
+credential` following these steps:
 
   1. Generate a credential description based on the context.
 +
 For example, if we want a password for
 `https://example.com/foo.git`, we might generate the following
-credential description (don't forget the blank line at the end):
+credential description (don't forget the blank line at the end; it
+tells `git credential` that the application finished feeding all the
+infomation it has):
 
          protocol=https
          host=example.com
@@ -62,22 +64,30 @@ credential description (don't forget the blank line at the end):
 
   2. Ask git-credential to give us a username and password for this
      description. This is done by running `git credential fill`,
-     feeding the description from step (1) to its stdin. The username
-     and password will be produced on stdout, like:
+     feeding the description from step (1) to its standard input. The
+     credential will be produced on standard output, like:
 
 	username=bob
 	password=secr3t
++
+If the `git credential` knew about the password, this step may
+not have involved the user actually typing this password (the
+user may have typed a password to unlock the keychain instead,
+or no user interaction was done if the keychain was already
+unlocked) before it returned `password=secr3t`.
 
-  3. Try to use the credential (e.g., by accessing the URL with the
-     username and password from step (2)).
+  3. Use the credential (e.g., access the URL with the username and
+     password from step (2)), and see if it's accepted.
 
   4. Report on the success or failure of the password. If the
      credential allowed the operation to complete successfully, then
-     it can be marked with an "approve" action. If the credential was
-     rejected during the operation, use the "reject" action. In either
-     case, `git credential` should be fed with the credential
-     description obtained from step (2) together with the ones already
-     provided in step (1).
+     it can be marked with an "approve" action to tell `git
+     credential` to reuse it in its next invocation. If the credential
+     was rejected during the operation, use the "reject" action so
+     that `git credential` will ask for a new password in its next
+     invocation. In either case, `git credential` should be fed with
+     the credential description obtained from step (2) together with
+     the ones already provided in step (1).
 
 [[IOFMT]]
 INPUT/OUTPUT FORMAT
@@ -85,7 +95,7 @@ INPUT/OUTPUT FORMAT
 
 `git credential` reads and/or writes (depending on the action used)
 credential information in its standard input/output. These information
-can correspond either to keys from which `git credential` will obtain
+can correspond either to keys for which `git credential` will obtain
 the login/password information (e.g. host, protocol, path), or to the
 actual credential data to be obtained (login/password).
 
diff --git a/builtin/credential.c b/builtin/credential.c
index 4147314..c185c07 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -1,11 +1,11 @@
-#include <stdio.h>
+#include "git-compat-util.h"
 #include "credential.h"
 #include "builtin.h"
 
 static const char usage_msg[] =
-	"credential <fill|approve|reject>";
+	"git credential [fill|approve|reject]";
 
-int cmd_credential (int argc, const char **argv, const char *prefix)
+int cmd_credential(int argc, const char **argv, const char *prefix)
 {
 	const char *op;
 	struct credential c = CREDENTIAL_INIT;


-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

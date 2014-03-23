From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Git-hooks pre-push script does not receive input on stdin
Date: Sun, 23 Mar 2014 08:19:47 +0100
Message-ID: <532E8B13.9060402@web.de>
References: <CAC1XvcPshKQXuRPDd8reb6fsDU3BNOsBAUKO25_dVBD331=yRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: David Cowden <dcow90@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 23 08:19:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRchI-0001fC-Ol
	for gcvg-git-2@plane.gmane.org; Sun, 23 Mar 2014 08:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbaCWHTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2014 03:19:51 -0400
Received: from mout.web.de ([212.227.17.12]:54322 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751AbaCWHTu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2014 03:19:50 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MXpdL-1WdZLP16tL-00WoeA; Sun, 23 Mar 2014 08:19:48
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <CAC1XvcPshKQXuRPDd8reb6fsDU3BNOsBAUKO25_dVBD331=yRQ@mail.gmail.com>
X-Provags-ID: V03:K0:fmfDCaJC73hAXNeLs8Vr0RwMG8Xi+CY8PImpVykAeOFOPmhpkhS
 Iki+aknF3noYeIYMYrGj5+DscoU5rbKv1SpZRnSAZM2uJbd1c47tk00HHvYcx79TWH1QW99
 3kiFwDdHrcl2/6Pr/0Mu43pEJSbTJHV7viuYbqPmi8vLpd80AxHxZrTf4x8BZ63eoddhPFO
 CPtA+ZIoGYsAobwS6W9Lg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244789>

On 2014-03-23 01.44, David Cowden wrote:
> http://stackoverflow.com/questions/22585091/git-hooks-pre-push-script-does-not-receive-input-via-stdin
> 
> Is this a bug in git?  Or am I just a shell noob?
> 
> Thanks in advance,
> 
> David

I assume that you have the right version of Git ?
You can look into the source of Git, to be more exact the test suite:
t/t5571-pre-push-hook.sh

When I play a little but with the script,
(Replace the diff with test_cmp, add a line:
diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
index 6f9916a..01db2fb 100755
--- a/t/t5571-pre-push-hook.sh
+++ b/t/t5571-pre-push-hook.sh
@@ -42,6 +42,7 @@ export COMMIT2
 write_script "$HOOK" <<'EOF'
 echo "$1" >actual
 echo "$2" >>actual
+echo hello >>actual
 cat >>actual
 EOF
-------------
and finally run it like this:

debug=t verbose=t ./t5571-pre-push-hook.sh  2>&1 | less
I get something like this:

--- expected    2014-03-23 07:15:58.000000000 +0000
+++ actual      2014-03-23 07:15:58.000000000 +0000
@@ -1,3 +1,4 @@
 parent1
 repo1
+hello
 refs/heads/master 139b20d8e6c5b496de61f033f642d0e3dbff528d refs/heads/foreign d79ce1670bdcb76e6d1da2ae095e890ccb326ae9
not ok 4 - push with hook
#       
#               git push parent1 master:foreign &&
#               test_cmp expected actual
#       
--------------------------------------------
So the question is, if your push simply doesn't have anything to push,
because everything is up to date?
And in this case there is nothing on STDIN?

If the problem still exists, feel free to post a script how to reproduce it
here to the list, t5571 may be a source of inspiration.

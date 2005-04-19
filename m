From: Tupshin Harper <tupshin@tupshin.com>
Subject: Re: Darcs and git: plan of action
Date: Tue, 19 Apr 2005 16:32:09 -0700
Message-ID: <426594F9.4090002@tupshin.com>
References: <20050418210436.23935.qmail@science.horizon.com>	
	<1113869248.23938.94.camel@orca.madrabbit.org>	
	<42645969.2090609@qualitycode.com>	
	<1113874931.23938.111.camel@orca.madrabbit.org>	
	<4264677A.9090003@qualitycode.com>	
	<1113950442.29444.31.camel@orca.madrabbit.org>	
	<42658E38.1020406@qualitycode.com>
	<1113951972.29444.42.camel@orca.madrabbit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Kevin Smith <yarcs@qualitycode.com>,
	darcs-devel@darcs.net
X-From: darcs-devel-bounces@darcs.net Wed Apr 20 01:28:53 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO29E-0003pY-3W
	for gcvdd-darcs-devel@m.gmane.org; Wed, 20 Apr 2005 01:28:52 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DO2Co-0002xx-L5; Tue, 19 Apr 2005 19:32:34 -0400
Received: from adsl-69-233-54-142.dsl.pltn13.pacbell.net ([69.233.54.142]
	helo=bastard.smallmerchant.com)
	by abridgegame.org with esmtp (Exim 4.50) id 1DO2Cl-0002xm-Sa
	for darcs-devel@darcs.net; Tue, 19 Apr 2005 19:32:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by bastard.smallmerchant.com (Postfix) with ESMTP id 15A023A016C;
	Tue, 19 Apr 2005 16:37:42 -0700 (PDT)
Received: from bastard.smallmerchant.com ([127.0.0.1])
	by localhost (mail.smallmerchant.com [127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 26268-03-5; Tue, 19 Apr 2005 16:37:28 -0700 (PDT)
Received: from [172.16.1.197] (unknown [172.16.1.197])
	by bastard.smallmerchant.com (Postfix) with ESMTP id 7B29D3A0161;
	Tue, 19 Apr 2005 16:37:28 -0700 (PDT)
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Ray Lee <ray-lk@madrabbit.org>
In-Reply-To: <1113951972.29444.42.camel@orca.madrabbit.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at smallmerchant.com
X-BeenThere: darcs-devel@darcs.net
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "List for darcs-related development discussion."
	<darcs-devel.darcs.net>
List-Unsubscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=unsubscribe>
List-Archive: <http://www.abridgegame.org/pipermail/darcs-devel>
List-Post: <mailto:darcs-devel@darcs.net>
List-Help: <mailto:darcs-devel-request@darcs.net?subject=help>
List-Subscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=subscribe>
Sender: darcs-devel-bounces@darcs.net
Errors-To: darcs-devel-bounces@darcs.net

Ray Lee wrote:

> I'm still not communicating well.
>
>Give me a case where assuming it's a replace will do the wrong thing,
>for C code, where it's a variable or function name.
>
>Ray
>
>-
>
I think you are communicating fine, but not fully understanding darcs.

try this:
initial patch creates hello.c
#include <stdio.h>

int main(int argc, char *argv[])
{
  printf("Hello world!\n");
  return 0;
}

second patch:
replace ./hello.c [A-Za-z_0-9] world universe

third patch, for conceptual clarity, created in another repository that 
had seen the first patch, but not the second (adds function wide_world):
hunk ./hello.c 3
+void wide_world()
+{
+  printf("Hello wide world\n");
+}
+
hunk ./hello.c 11
+  wide_world();
}

If patch2 was a replace patch, then the result of running the combined 3 
patch version would be:
Hello universe!
Hello wide universe

but if patch2 was a non-replace patch, then the result would be:
Hello universe!
Hello wide world

-Tupshin

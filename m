Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E0BC43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 01:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbiGGBub (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 21:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiGGBua (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 21:50:30 -0400
Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E7A2A97F
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 18:50:27 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id 9GeroJnAxGjO89GesovROw; Thu, 07 Jul 2022 02:50:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1657158625; bh=JkAXvXI8d1N0njUS5su0WN3xuqf4KX9ewVndVMynvc4=;
        h=Date:To:Cc:From:Subject;
        b=I4H+XH5o18a5Zh6beZfkD5FNsXUgqGUvW4q35EwZUAZJRn2PN+Wcd/gGWOYvhQykc
         757rEPv+gEyK01OMVE+tTJKFIBt8g91WlxqpUrDL1g0h1hfU8y868adIqLul8yppOx
         vfc8IzFb7k5EJvqILeHB+oFEm5ccWcCh55Lp+bT980OPvEcVFdz3dYJP166/6jxpPM
         NYjrdvcAKs3YQZounhCc1L2OAATkRDda2rydEM/RRl0rOVT1xKNS4SsDSU0XMs9mJS
         /hmd2avUiYBwdmZLpgkUzbSD9Wdi+m+tLdn8L/SuDz5TxWRYkCTX3qpF+76xKLK0Yk
         ibAifYYUKUlcg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=HttlpmfS c=1 sm=1 tr=0 ts=62c63be1
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=EBOSESyhAAAA:8 a=w_pzkKWiAAAA:8
 a=4E8Iy2Z0mhPwGh3-yF4A:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=yJM6EZoI5SlJf8ks9Ge_:22 a=sRI3_1zDfAgwuvI8zelB:22
X-AUTH: ramsayjones@:2500
Message-ID: <9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com>
Date:   Thu, 7 Jul 2022 02:50:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-GB
To:     GIT Mailing-list <git@vger.kernel.org>,
        Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: t0301-credential-cache test failure on cygwin
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDTl5vUU4A1eIaULu9oBJnjZxHexcMrgFeDRAVn7vwGV91tVxGoNU8w0v7bUcVrMTag05r9WvNqcHnJJuHCwVwfvDp+U4aAAgFBejhr5QNxj+uJD3rWD
 WMKCnNox0UmrTIAEwGhmlXowqNY99FOvZcfpSmppJrOgDJlIZSsYSiUeYMRJgExkNmlTtnWAlZhlkGxmydREhJikMBZC6t9FiSs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


During the v2.34.0 development cycle, between -rc1 and -rc2, as a result of an
update to cygwin, test t0301-credential-cache started failing on cygwin (it had
never failed before then). This was noted in [1] and later Adam (cygwin git
maintainer) confirmed this was due to a change in cygwin (there had been many
changes to the 'pipe' code).

Given that 'ssh-agent' provides all of my 'password' keeping needs, I have to
admit that, at the time, I was not overly concerned about the failure. :(
(Also, it was a cygwin failure, so no need to fix git).

However, I had some time to kill tonight, so I decided to take a _quick_ look
to see if there was something that could be done ... (famous last words).

  $ cd t
  $ ./t0301-credential-cache.sh -i -v -x

  ...

  expecting success of 0301.13 'socket defaults to ~/.cache/git/credential/socket':
          test_when_finished "
                  git credential-cache exit &&
                  rmdir -p .cache/git/credential/
          " &&
          test_path_is_missing "$HOME/.git-credential-cache" &&
          test_path_is_socket "$HOME/.cache/git/credential/socket"
  
  ++ test_when_finished '
                  git credential-cache exit &&
                  rmdir -p .cache/git/credential/
          '
  ++ test 0 = 0
  ++ test_cleanup='{
                  git credential-cache exit &&
                  rmdir -p .cache/git/credential/
  
                  } && (exit "$eval_ret"); eval_ret=$?; :'
  ++ test_path_is_missing '/home/ramsay/git/t/trash directory.t0301-credential-cache/.git-credential-cache'
  ++ test 1 -ne 1
  ++ test -e '/home/ramsay/git/t/trash directory.t0301-credential-cache/.git-credential-cache'
  ++ test_path_is_socket '/home/ramsay/git/t/trash directory.t0301-credential-cache/.cache/git/credential/socket'
  ++ test -S '/home/ramsay/git/t/trash directory.t0301-credential-cache/.cache/git/credential/socket'
  ++ git credential-cache exit
  fatal: read error from cache daemon: Software caused connection abort
  ++ eval_ret=128
  ++ :
  not ok 13 - socket defaults to ~/.cache/git/credential/socket
  #
  #               test_when_finished "
  #                       git credential-cache exit &&
  #                       rmdir -p .cache/git/credential/
  #               " &&
  #               test_path_is_missing "$HOME/.git-credential-cache" &&
  #               test_path_is_socket "$HOME/.cache/git/credential/socket"
  #
  1..13
  ++ git credential-cache exit
  ++ exit 128
  ++ eval_ret=128
  ++ :
  $

Around the time of v2.34.0-rc2, problems with the cygwin 'unix-stream-socket'
emulation caused some t0052-simple-ipc tests to fail (indeed the mailing-list
thread containing [1] was actually related to that failure). These problems
were fixed in commit 974ef7ced2 (simple-ipc: work around issues with Cygwin's
Unix socket emulation, 2021-11-10).

So, I was half expecting the failure to be noted at the 'test_path_is_socket'
line in the test. As you can see, it actually fails in the 'test_when_finished'
block with the 'git credential-cache exit', and the failure given as:

  fatal: read error from cache daemon: Software caused connection abort

looking at builtin/credential-cache.c, lines 40-66, we see:

    40	static int send_request(const char *socket, const struct strbuf *out)
    41	{
    42		int got_data = 0;
    43		int fd = unix_stream_connect(socket, 0);
    44	
    45		if (fd < 0)
    46			return -1;
    47	
    48		if (write_in_full(fd, out->buf, out->len) < 0)
    49			die_errno("unable to write to cache daemon");
    50		shutdown(fd, SHUT_WR);
    51	
    52		while (1) {
    53			char in[1024];
    54			int r;
    55	
    56			r = read_in_full(fd, in, sizeof(in));
    57			if (r == 0 || (r < 0 && connection_closed(errno)))
    58				break;
    59			if (r < 0)
    60				die_errno("read error from cache daemon");
    61			write_or_die(1, in, r);
    62			got_data = 1;
    63		}
    64		close(fd);
    65		return got_data;
    66	}

So, the read_in_full() call is returning an error, the error code is not
one that connection_closed() recognised and die_errno() is called at
line #60 (with errno=113).

Looking in the <errno.h> header file, we see:

  #define ECONNABORTED 113        /* Software caused connection abort */

Now, I find this a little odd, since most descriptions of ECONNABORTED
indicate that it is an error caused by the client but returned to the
server from the accept() call. This is definitely not what is happening
here. :)

Anyway, the somewhat loose meanings assigned to error codes aside, one
simple solution would be:

  diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
  index 78c02ad531..84fd513c62 100644
  --- a/builtin/credential-cache.c
  +++ b/builtin/credential-cache.c
  @@ -27,7 +27,7 @@ static int connection_fatally_broken(int error)
   
   static int connection_closed(int error)
   {
  -	return (error == ECONNRESET);
  +	return (error == ECONNRESET) || (error == ECONNABORTED);
   }
   
   static int connection_fatally_broken(int error)
  --

.. which does, indeed, 'fix' the problem. (Well, it side-steps the problem,
really).

Having deleted the above patch, I now had a look at the server side. Tracing
out the server execution showed no surprises - everything progressed as one
would expect and it 'exit(0)'-ed correctly! The relevant part of the code to
process a client request (in the serve_one_client() function, lines 132-142
in builtin/credential-cache--daemon.c) looks like:

	else if (!strcmp(action.buf, "exit")) {
		/*
		 * It's important that we clean up our socket first, and then
		 * signal the client only once we have finished the cleanup.
		 * Calling exit() directly does this, because we clean up in
		 * our atexit() handler, and then signal the client when our
		 * process actually ends, which closes the socket and gives
		 * them EOF.
		 */
		exit(0);
	}

Now, the comment doesn't make clear to me why "it's important that we clean
up our socket first" and, indeed, whether 'socket' refers to the socket
descriptor or the socket file. In the past, all of my unix-stream-socket
servers have closed the socket descriptor and then unlink()-ed the socket
file before exit(), with no 'atexit' calls in sight (lightly cribbed from a
30+ years old Unix Network programming book by Stevens - or was it the Comer
book - or maybe the Comer and Stevens book - I forget!).

The C standard (see C11 7.22.4.4) says that the 'exit' function first calls
all functions registered by 'atexit', then all open streams with unwritten
buffered data are flushed, all open streams are closed, and all files created
by the 'tmpfile' function are removed.

The C standard can only refer to 'FILE *' streams, but POSIX says practically
the same, but in addition (see 'Consequences of Process Termination'), that
"All of the file descriptors, directory streams, conversion descriptors,
and message catalog descriptors open in the calling process shall be closed."

Note that the above descriptions do not nail down the _exact_ ordering of
certain cleanup operations. (eg do the file descriptors get closed in a
low->high, high->low or random order)? So, if the cleanup operations can
fail, depending on the order of operations, then the results could be
undefined.

Anyway, I started playing around with flushing/closing of 'FILE *' streams
before the 'exit' call, to change the order, relative to the socket-file
deletion in the 'atexit' function (or the closing of the listen-socket
descriptor, come to that). In particular, I found that if I were to close
the 'in'put stream, then the client would receive an EOF and exit normally
(ie no error return from read_in_full() above).

[fclose(in); fclose(out) also works, but fclose(out) on its own does not.
fflush() in various combinations did not work at all].

So, the following patch also provides a 'fix' for this issue (although it
would require a change to the comment for a _real_ patch):

  diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
  index 4c6c89ab0d..556393498f 100644
  --- a/builtin/credential-cache--daemon.c
  +++ b/builtin/credential-cache--daemon.c
  @@ -138,6 +138,7 @@ static void serve_one_client(FILE *in, FILE *out)
   		 * process actually ends, which closes the socket and gives
   		 * them EOF.
   		 */
  +		fclose(in);
   		exit(0);
   	}
   	else if (!strcmp(action.buf, "erase"))
  --

Having noticed that the 'timeout' test was not failing, I decided to try
making the 'action=exit' code-path behave more like the timeout code, as
far as exiting the server is concerned. Indeed, you might ask why the
timeout code doesn't just 'exit(0)' as well ...

Anyway, the following patch does that, and it also provides a 'fix' for this
issue!

  diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
  index 4c6c89ab0d..fb9b1e04a6 100644
  --- a/builtin/credential-cache--daemon.c
  +++ b/builtin/credential-cache--daemon.c
  @@ -114,11 +114,12 @@ static int read_request(FILE *fh, struct credential *c,
   	return 0;
   }
   
  -static void serve_one_client(FILE *in, FILE *out)
  +static int serve_one_client(FILE *in, FILE *out)
   {
   	struct credential c = CREDENTIAL_INIT;
   	struct strbuf action = STRBUF_INIT;
   	int timeout = -1;
  +	int serve = 1; /* ie continue to serve clients */
   
   	if (read_request(in, &c, &action, &timeout) < 0)
   		/* ignore error */ ;
  @@ -130,15 +131,8 @@ static void serve_one_client(FILE *in, FILE *out)
   		}
   	}
   	else if (!strcmp(action.buf, "exit")) {
  -		/*
  -		 * It's important that we clean up our socket first, and then
  -		 * signal the client only once we have finished the cleanup.
  -		 * Calling exit() directly does this, because we clean up in
  -		 * our atexit() handler, and then signal the client when our
  -		 * process actually ends, which closes the socket and gives
  -		 * them EOF.
  -		 */
  -		exit(0);
  +		/* stop serving clients */
  +		serve = 0;
   	}
   	else if (!strcmp(action.buf, "erase"))
   		remove_credential(&c);
  @@ -157,6 +151,7 @@ static void serve_one_client(FILE *in, FILE *out)
   
   	credential_clear(&c);
   	strbuf_release(&action);
  +	return serve;
   }
   
   static int serve_cache_loop(int fd)
  @@ -179,6 +174,7 @@ static int serve_cache_loop(int fd)
   	if (pfd.revents & POLLIN) {
   		int client, client2;
   		FILE *in, *out;
  +		int serve;
   
   		client = accept(fd, NULL, NULL);
   		if (client < 0) {
  @@ -194,9 +190,10 @@ static int serve_cache_loop(int fd)
   
   		in = xfdopen(client, "r");
   		out = xfdopen(client2, "w");
  -		serve_one_client(in, out);
  +		serve = serve_one_client(in, out);
   		fclose(in);
   		fclose(out);
  +		return serve;
   	}
   	return 1;
   }
  -- 

[Note the 'serve' variable was the least objectionable name I could come up
with, but it could probably be improved!]

So, we now have three patches which 'fix' the issue. What does this tell us?
Well, not an awful lot! ;-)

I repeat, until I updated to v3.3.2 of cygwin, none of these patches were
required, since the test did not fail. In order to progress, someone needs
to bisect the commits in the cygwin git repository to find the commit which
changed the behaviour of the unix stream socket emulation.

I had a look at the cygwin gitweb site [2], and started reading the commit
messages from 'cygwin-3_3_2-release' tag, but nothing stood out. Also, I did
not note (in [1]) which version of cygwin I updated _from_, so I don't know
where to stop! (Sometimes I update often, sometimes not for 6-9 months!
I have a vague feeling that I was in a reasonably often update tempo, so
there may be no need to go too far back).

[Also, I spent loads of time reading the code [3] to the 'fhandler_socket_unix'
class, only to notice that it is conditional on the '__WITH_AF_UNIX'
pre-processor variable. I can't find any code which #defines it, so ...]

[Also, in [1] I noted that the v3.3.2 update added an hour to the runtime
of the testsuite. If I run the test something like:

  $ export GIT_TEST_CHAIN_LINT=0
  $ export TEST_NO_MALLOC_CHECK=yes
  $ make test >test-out-2-37-rel 2>&1

.. then I can get back about 45min of that hour!

(I also have DEFAULT_TEST_TARGET=prove and GIT_PROVE_OPTS='--timer' in my
config.mak)]

Unfortunately, I can't be the one to investigate the change to cygwin, so I
will have to leave that to someone with the necessary knowledge/skill with
the cygwin codebase. (The last time I built/debugged the cygwin .dll, the
repo was in cvs! Yes, many, many years ago. If I remember correctly, building
the .dll wasn't really the problem - it was the testing that was the *huge*
PITA, especially if you have services running).

It seems unlikely, but it is possible (despite what I said earlier), that the
fault lies with git - it could be relying on implementation behaviour. Until
we know how cygwin changed, we will not be able to determine a suitable fix.

Hmm, I will send the three RFC patches to the list, just to make it slightly
easier for someone to try them out, if they wish.

Sorry for not looking at this earlier and for not finding a suitable fix.

It's getting late ...


ATB,
Ramsay Jones

[1] https://lore.kernel.org/git/02b6cfa8-bd0a-275d-fce0-a3a9f316ded3@ramsayjones.plus.com/
[2] https://cygwin.com/git/newlib-cygwin.git
[3] https://cygwin.com/git/?p=newlib-cygwin.git;a=blob;f=winsup/cygwin/fhandler_socket_unix.cc;h=8abb581b999e79ad71ddd19a1557e2be0fd9d757;hb=5cc4b92c25af1af9250e4498e60943fcc82b7487



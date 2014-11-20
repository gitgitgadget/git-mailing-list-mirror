From: Philip Oakley <philipoakley@iee.org>
Subject: [RFC 3/4] engine.pl: split the .o and .obj processing
Date: Thu, 20 Nov 2014 23:38:01 +0000
Message-ID: <1416526682-6024-4-git-send-email-philipoakley@iee.org>
References: <1416526682-6024-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Wookey <michaelwookey@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Msysgit <msysgit@googlegroups.com>
To: GitList <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBSHWXGRQKGQENSCOJ5Y@googlegroups.com Fri Nov 21 00:37:46 2014
Return-path: <msysgit+bncBDSOTWHYX4PBBSHWXGRQKGQENSCOJ5Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f189.google.com ([209.85.212.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBSHWXGRQKGQENSCOJ5Y@googlegroups.com>)
	id 1XrbII-0002YG-8d
	for gcvm-msysgit@m.gmane.org; Fri, 21 Nov 2014 00:37:46 +0100
Received: by mail-wi0-f189.google.com with SMTP id r20sf371302wiv.26
        for <gcvm-msysgit@m.gmane.org>; Thu, 20 Nov 2014 15:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe;
        bh=/YHhT2qtBlecivDuMifKnm7/qdkfh5DVAcFlXQnWlgE=;
        b=YHr+xNMl7KpFYIToJCt0vykoNj+/4YUkHR5feYS0kamNOIsEHj8xtwfe4EKnNlhQEK
         rI6nJNNITki6wMg9zJCc0SQvXwKm7TBshS2Opz4ZWo+6c6I+pB1RL+6sZN7X7tW+Mczm
         yBASkH2OTPz/fPXmFvqThPKgYw6z0p741HbUCES348yEPqlqmZgQNXSngzUAguWr7VNe
         cHxN58w+8g3E0D2vcNrjpXXBmZqzoMO0EHlLg6cnpjR1u+U/HOQVaj7ChUxdE6j4k/tc
         L51PwOVFufpaqTaZ8BCjZYpCw0WCPg4USPTkRVTZ2jzsNjc4MWw2ahgAxOsw0R5avtUl
         u+cQ==
X-Received: by 10.152.29.228 with SMTP id n4mr13425lah.16.1416526666071;
        Thu, 20 Nov 2014 15:37:46 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.206.102 with SMTP id ln6ls118368lac.95.gmail; Thu, 20 Nov
 2014 15:37:44 -0800 (PST)
X-Received: by 10.112.204.71 with SMTP id kw7mr351108lbc.13.1416526664237;
        Thu, 20 Nov 2014 15:37:44 -0800 (PST)
Received: from out1.ip06ir2.opaltelecom.net (out1.ip06ir2.opaltelecom.net. [62.24.128.242])
        by gmr-mx.google.com with ESMTP id jv2si90840wid.1.2014.11.20.15.37.44
        for <msysgit@googlegroups.com>;
        Thu, 20 Nov 2014 15:37:44 -0800 (PST)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.242 as permitted sender) client-ip=62.24.128.242;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmoOAPx5blROl3PwPGdsb2JhbABagw5VWYI2hFPET4dLBAICgQYXAQEBAQEBBQEBAQE4O4QDAQVWIxAISTkKFAYTiEXUfAEBAQEGAiCRCAeESwWXNYkcmQY9MIJLAQEB
X-IPAS-Result: AmoOAPx5blROl3PwPGdsb2JhbABagw5VWYI2hFPET4dLBAICgQYXAQEBAQEBBQEBAQE4O4QDAQVWIxAISTkKFAYTiEXUfAEBAQEGAiCRCAeESwWXNYkcmQY9MIJLAQEB
X-IronPort-AV: E=Sophos;i="5.07,426,1413241200"; 
   d="scan'208";a="651403030"
Received: from host-78-151-115-240.as13285.net (HELO localhost) ([78.151.115.240])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 20 Nov 2014 23:37:43 +0000
X-Mailer: git-send-email 1.9.4.msysgit.0
In-Reply-To: <1416526682-6024-1-git-send-email-philipoakley@iee.org>
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.242 as permitted sender) smtp.mail=philipoakley@iee.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

Commit 4b623d80f7352 added an .obj file (invalidcontinue.obj) which was not
processed correctly.

The generate engine then mistakenly did a s/.o/.c/  to create a request
to compile invalidcontinue.cbj.

Split the '/\.(o|obj)$' in engine.pl#L353 into:

        } elsif ($part =~ /\.o$/) { # was '/\.(o|obj)$'
            push(@objfiles, $part);
        } elsif ($part =~ /\.obj$/) { # was '/\.(o|obj)$'
            # push(@objfiles, $part); # do nothing
        } else {

And correct the substitution to only operate on .o files.

Also report all errors rather than dieing on the first

 $ git describe 4b623d80f7352
 v1.9.1-1-g4b623d8
The problem exists for V1.9.2 onward

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 contrib/buildsystems/engine.pl | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 8e41808..16c3dd5 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -264,7 +264,9 @@ sub handleCompileLine
         } elsif ($part =~ /\.(c|cc|cpp)$/) {
             $sourcefile = $part;
         } else {
-            die "Unhandled compiler option @ line $lineno: $part";
+            print "full line: $line\n";
+            print "A:-Unhandled compiler option @ line $lineno: $part\n"; # die (if !DEBUG)
+#            die "Unhandled compiler option @ line $lineno: $part";
         }
     }
     @{$compile_options{"${sourcefile}_CFLAGS"}} = @cflags;
@@ -290,14 +292,15 @@ sub handleLibLine
             $libout = $part;
             $libout =~ s/\.a$//;
         } else {
-            die "Unhandled lib option @ line $lineno: $part";
+            print "A:-Unhandled lib option @ line $lineno: $part\n"; # die (if !DEBUG)
+#           die "Unhandled lib option @ line $lineno: $part";
         }
     }
 #    print "LibOut: '$libout'\nLFlags: @lflags\nOfiles: @objfiles\n";
 #    exit(1);
     foreach (@objfiles) {
         my $sourcefile = $_;
-        $sourcefile =~ s/\.o/.c/;
+        $sourcefile =~ s/\.o$/.c/;
         push(@sources, $sourcefile);
         push(@cflags, @{$compile_options{"${sourcefile}_CFLAGS"}});
         push(@defines, @{$compile_options{"${sourcefile}_DEFINES"}});
@@ -343,8 +346,10 @@ sub handleLinkLine
         } elsif ($part =~ /\.(a|lib)$/) {
             $part =~ s/\.a$/.lib/;
             push(@libs, $part);
-        } elsif ($part =~ /\.(o|obj)$/) {
+        } elsif ($part =~ /\.o$/) { # was '/\.(o|obj)$'
             push(@objfiles, $part);
+        } elsif ($part =~ /\.obj$/) { # was '/\.(o|obj)$'
+            # push(@objfiles, $part); # do nothing
         } else {
             die "Unhandled lib option @ line $lineno: $part";
         }
@@ -353,7 +358,7 @@ sub handleLinkLine
 #    exit(1);
     foreach (@objfiles) {
         my $sourcefile = $_;
-        $sourcefile =~ s/\.o/.c/;
+        $sourcefile =~ s/\.o$/.c/;
         push(@sources, $sourcefile);
         push(@cflags, @{$compile_options{"${sourcefile}_CFLAGS"}});
         push(@defines, @{$compile_options{"${sourcefile}_DEFINES"}});
-- 
1.9.4.msysgit.0

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

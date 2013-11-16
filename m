From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Access different NAMESPACE of remote repo from client side
Date: Sat, 16 Nov 2013 16:00:18 +0800
Message-ID: <CANYiYbHzHEFLshU8r-m=0CUo7JTu-iyv1W4N291hX8+r1BYY-w@mail.gmail.com>
References: <CANYiYbGiXkBQdXMGbcGV6WjtG82ax6z94TMatP2ZTQ54=KgMjg@mail.gmail.com>
	<52862EEE.8010800@gmail.com>
	<52863410.9090508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Jamey Sharp <jamey@minilop.net>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 16 09:00:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vhao2-0001xX-B9
	for gcvg-git-2@plane.gmane.org; Sat, 16 Nov 2013 09:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092Ab3KPIAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 03:00:34 -0500
Received: from mail-wi0-f181.google.com ([209.85.212.181]:48896 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab3KPIAT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Nov 2013 03:00:19 -0500
Received: by mail-wi0-f181.google.com with SMTP id f4so1926480wiw.14
        for <git@vger.kernel.org>; Sat, 16 Nov 2013 00:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=N0M8EwEiUWhxqwr5CkxnTE0ur3o72S0HZCo4UssLl+0=;
        b=G/INaA70byQ2Qe86vxT/ypSfO4chLnd87RxQNDw4XtVVIX+AeAthq7gtgCDGYv6H7O
         Nz9U7+6kx3OfbQGFSnQ2WDlY0RUJuFSH4nyJKRLtuiWIE6JwFC8AUhJLSxpmfUbLJRzv
         XynNIlVG7uE81muQNCc1qUyNqrWXy/+q68NGoint9Wbl3x6S3fLTSY2+Hx25amcLVJ2O
         o92gp2YbyLOnwwqoTEThg9vpQlq0Qf1QknK7FyXTRfmy1nvcGcSWUMSftlE7UnsYy7EZ
         n+iZH275UJl/idGydItRUHhxkwRIS1V948TO+HgzuVW8PJgqtylqGwlAHBMmiJsKTg42
         VNTg==
X-Received: by 10.194.23.8 with SMTP id i8mr394943wjf.68.1384588818354; Sat,
 16 Nov 2013 00:00:18 -0800 (PST)
Received: by 10.216.122.202 with HTTP; Sat, 16 Nov 2013 00:00:18 -0800 (PST)
In-Reply-To: <52863410.9090508@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237925>

2013/11/15 Sitaram Chamarty <sitaramc@gmail.com>:
> On 11/15/2013 07:55 PM, Sitaram Chamarty wrote:
>> On 11/15/2013 01:49 PM, Jiang Xin wrote:
>>> Just like solution 2, these settings won't work without a patched
>>> git-shell or gitolite.
>>
>> Gitolite has a namespaces branch that handles namespaces as described in
>> http://gitolite.com/gitolite/namespaces.html
>>
>> Briefly, it recognises that you can have a "main" repo off of which
>> several developer might want to hang their logical repos.
>>
>> It also recognises that the actual names of the logical repos will
>> follow some pattern that may include the name of the developer also, and
>> provides a way to derive the name of the physical repo from the logical
>> one.
>>
>> There is an example or two in that link.

I use gitolite everyday, and thank you for inventing it. I use gitolite v2 for
a long time, and migrated to v3 recently. Thank you for pointing out
there is a "namespace" feature branch, and I love the implementation
very much, it is so easy to map logical repos to one physical repo.

>
> I should add that the Gitolite model is: the user doesn't need to know
> about namespaces, because namespaces are just things that the server
> admin is setting up for his own reasons...
>

I want to say something that git-namespace is sometimes significant
for normal user not only for admin.

Some of my repos are managed by Topgit. With the help of topgit,
dependance of the topic branch (usually named as "t/feature-name")
are tracked by file ".topdeps" and a special ref named as
"refs/top-bases/t/feature-name". So there are many topic branches
and many useful special refs.

Every time when I want to update all topic branches to the new
upstream version, just before run "tg update", I want to take a
snapshoot of all branches and refs. Clone is heavy, so I want to use
light-weight namespace.

If the server is out of my control, it would be nice to let the user pass
namespace to the server from client side.

Indeed, I patched gitolite first as the follows, than I find out git-shell
needs to be patched too.


diff --git a/src/gitolite-shell b/src/gitolite-shell
index 7a27cc0..1c957da 100755
--- a/src/gitolite-shell
+++ b/src/gitolite-shell
@@ -101,7 +101,7 @@ sub main {
     my $user = $ENV{GL_USER} = shift @ARGV;

     # set up the repo and the attempted access
-    my ( $verb, $repo ) = parse_soc();    # returns only for git commands
+    my ( $verb, $option, $repo ) = parse_soc();    # returns only for
git commands
     sanity($repo);
     $ENV{GL_REPO} = $repo;
     my $aa = ( $verb =~ 'upload' ? 'R' : 'W' );
@@ -135,7 +135,11 @@ sub main {
         _system( "git", "http-backend" );
     } else {
         my $repodir = "'$rc{GL_REPO_BASE}/$repo.git'";
-        _system( "git", "shell", "-c", "$verb $repodir" );
+        my $cmd = $verb;
+        if ($option) {
+            $cmd =~ s/^(git)[- ](.*)$/$1 $option $2/;
+        }
+        _system( "git", "shell", "-c", "$cmd $repodir" );
     }
     trigger( 'POST_GIT', $repo, $user, $aa, 'any', $verb );
 }
@@ -146,13 +150,24 @@ sub parse_soc {
     my $soc = $ENV{SSH_ORIGINAL_COMMAND};
     $soc ||= 'info';

-    my $git_commands = "git-upload-pack|git-receive-pack|git-upload-archive";
-    if ( $soc =~ m(^($git_commands) '/?(.*?)(?:\.git(\d)?)?'$) ) {
-        my ( $verb, $repo, $trace_level ) = ( $1, $2, $3 );
+    my $git_commands = "upload-pack|receive-pack|upload-archive";
+    my ( $verb, $option, $repo, $trace_level );
+    if ( $soc =~
m(^git\s+(?:(--namespace)(?:=|\s+)(\S+)\s+)?(\S+)\s+'/?(.*?)(?:\.git(\d)?)?'$)
) {
+        $option = "$1=$2";
+        $verb = "git-$3";
+        $repo = $4;
+        $trace_level = $5;
+    } elsif ( $soc =~ m(^git[- ]($git_commands) '/?(.*?)(?:\.git(\d)?)?'$) ) {
+        $verb = "git-$1";
+        $repo = $2;
+        $trace_level = $3;
+    }
+
+    if ($verb) {
         $ENV{D} = $trace_level if $trace_level;
         _die "invalid repo name: '$repo'" if $repo !~ $REPONAME_PATT;
         trace( 2, "git command", $soc );
-        return ( $verb, $repo );
+        return ( $verb, $option, $repo );
     }

     # after this we should not return; caller expects us to handle it all here



-- 
Jiang Xin

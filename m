From: Junio C Hamano <junkio@cox.net>
Subject: The latest commit to add new keybindings
Date: Fri, 23 Sep 2005 18:31:20 -0700
Message-ID: <7v4q8b8d5j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 03:31:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIyt3-00022Z-4B
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 03:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVIXBbX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 21:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbVIXBbX
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 21:31:23 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:43392 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750820AbVIXBbW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 21:31:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050924013122.UZLW26433.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Sep 2005 21:31:22 -0400
To: Paul Mackerras <paulus@samba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9221>

Paul, I was looking at the gitk repository thinking it's about
time for me to slurp your changes in, and have two questions.

The 'new keybindings' commit from Robert Suetterlin changes the
beginning of gitk to:

        --- a/gitk
        +++ b/gitk
        @@ -1,6 +1,6 @@
         #!/bin/sh
         # Tcl ignores the next line -*- tcl -*- \
        -exec wish "$0" -- "${1+$@}"
        +exec wish8.4 "$0" -- "${1+$@}"

Do you actually require 8.4, or any reasonably recent wish would
do?  The reason I ask is that Debian side (debian/control)
explicitly depends on 'tk8.4' but RPM side (git-core.spec.in)
just says 'tk'.  I could change the RPM side to also require 8.4
but I do not have ready access to any RPM machine to test it
with, so if that is not needed I'd rather not touch spec.in
file.

Another thing, which is unrelated to Robert's change, is that I
suspect the exec command line should be like either one of these
(the first one is probably more old-fashioned):

	exec wish "$0" -- ${1+"$@"}
	exec wish "$0" -- "$@"

With "${1+$@}", you are passing an empty parameter after '--'
when gitk itself receives no parameter.  Maybe it is intended,
maybe not...

prompt$ cat >one.sh <<\EOF
#!/bin/sh
exec ./two.sh "$0" -- "${1+$@}"
EOF
prompt$ cat >two.sh <<\EOF
#!/bin/sh
echo "\$0 is $0"
echo "\$# is $#"
i=1
for a
do
	echo "\$$i is $a"
	i=`expr $i + 1`
done
EOF
prompt$ chmod +x one.sh two.sh
prompt$ ./one.sh foo
$0 is /var/tmp/gomi/two.sh
$# is 3
$1 is <./one.sh>
$2 is <-->
$3 is <foo>
prompt$ ./one.sh
$0 is /var/tmp/gomi/two.sh
$# is 3
$1 is <./one.sh>
$2 is <-->
$3 is <>
prompt$ exit

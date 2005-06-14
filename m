From: James Purser <purserj@winnsw.com.au>
Subject: Re: [PATCH] Adding Correct Useage Notification and -h Help flag
Date: Wed, 15 Jun 2005 07:49:36 +1000
Message-ID: <1118785776.3068.4.camel@kryten>
References: <1118713641.8712.10.camel@localhost.localdomain>
	 <7vmzptbrsg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-uNgNsQROX8OrkqKwaqWn"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 23:43:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiJB0-0007Hl-4D
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 23:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVFNVrZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 17:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVFNVrY
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 17:47:24 -0400
Received: from dsl-202-52-56-051.nsw.veridas.net ([202.52.56.51]:13184 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261355AbVFNVrH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2005 17:47:07 -0400
Received: from localhost.localdomain (kryten [127.0.0.1])
	by localhost.localdomain (8.12.11/8.12.11) with ESMTP id j5ELnbxk005064;
	Wed, 15 Jun 2005 07:49:37 +1000
Received: (from purserj@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id j5ELnal7005061;
	Wed, 15 Jun 2005 07:49:36 +1000
X-Authentication-Warning: localhost.localdomain: purserj set sender to purserj@winnsw.com.au using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzptbrsg.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-uNgNsQROX8OrkqKwaqWn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heres the revised patch along the lines you recommended yesterday. I am
still working on some of the command descriptions.

On the git-update-cache question, I think having a flag [-u] or
something like that in git commit would allow the user to decide to run
git-update-cache on only the files specified in the git commit command.

Signed-off-by: James Purser <purserj@k-sit.com>
On Tue, 2005-06-14 at 12:23, Junio C Hamano wrote:
> >>Added a couple of lines to the git wrapper. Includes Correct
> >>Useage and available scripts
> 
> I like the general direction of making "git" wrapper novice
> friendly, but have some suggestions to the implementation.
> 
>  (0) Do not mention that only certain subset is accessible.
>      Just saying "Available commands are:" would be enough, and
>      would not leave the end user wondering what he is missing.
> 
>  (1) Instead of explicitly checking for -h, you may want to
>      structure it like this:
> 
>          #!/bin/sh
> 
>          cmd="git-$1-script";
>          shift;
>          exec $cmd "$@";
>          echo "Usage: git <subcommand> [<param>...]"
>          echo 'Available commands are:"
>          git bar
> 	 git foo
>          ...
>          '
>          exit 1
> 
>      Alternatively, you could say:
> 
>          #!/bin/sh
> 
>          case "$1" in
>          -h)
>              echo "Usage: git <subcommand> [<param>...]"
>              echo 'Available commands are:
>          git bar
> 	 git foo
>          ...
>          '
>              exit 0 ;;
> 	 esac
> 
>          cmd="git-$1-script";
>          shift;
>          exec $cmd "$@";
> 	 git -h
>          exit 1
> 
>  (2) Maintaining the list of commands by hand in git script
>      itself have an advantage that you _could_ describe the
>      options and parameters they take, but you are not doing
>      that in your patch (hint, hint).
> 
>      If all you give is the list of subcommand names, have
>      git.in as a source file, and create the "list of available
>      commands" from the Makefile, like this:
> 
>      === Makefile ===
>      ...
>      git : git.in
>          /bin/sh ls -1 git-*-script | \
>          sed -e 's/git-\(.*\)-script/git \1/' >.git-cmd-list
>          sed -e '/@@LIST_OF_COMMANDS@@/{s/.*//;r .git-cmd-list;}' <$@.in >$@
>          rm -f .git-cmd-list
> 
>      === git.in ===
>      #!/bin/sh
> 
>      cmd="git-$1-script";
>      shift;
>      exec $cmd "$@";
>      echo "Usage: git <subcommand> [<param>...]"
>      echo 'Available commands are:
>      @@LIST_OF_COMMANDS@@
>      '
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=-uNgNsQROX8OrkqKwaqWn
Content-Disposition: attachment; filename=git_patch
Content-Transfer-Encoding: base64
Content-Type: text/plain; name=git_patch; charset=utf-8

TWFrZSB0aGUgZ2l0IHdyYXBwZXIgYSBsaXR0bGUgYml0IG1vcmUgbmV3YmllIGZyaWVuZGx5LCB3
aGVuIGNhbGxlZCBvbiBpdHMgb3duIG9yIHdpdGggdGhlIC1oIGZsYWcgd2lsbCByZXR1cm4gYSBs
aXN0IG9mIHRoZSBjb21tYW5kcyBhdmFpbGFibGUNCg0KLS0tDQpjb21taXQgMmFkNDk5Zjc1ZjA5
ODI5NTNlNDM5MDQwODViZDFiNDhkZDgyMWM0ZA0KdHJlZSBmMTM3YzRmM2Y1ZWUwMjdiOGI0ZDI1
YTA0MzQ5MjllMTJlYjdjNTFjDQpwYXJlbnQgZGU0OTcxYjUwMDc2YjVlZjkwMWMyYWUwYmJlZTlk
ZDJjMTRmMDZlYQ0KcGFyZW50IGRlNDk3MWI1MDA3NmI1ZWY5MDFjMmFlMGJiZWU5ZGQyYzE0ZjA2
ZWENCmF1dGhvciBKYW1lcyBQdXJzZXIgPHB1cnNlcmpAay1zaXQuY29tPiBXZWQsIDE1IEp1biAy
MDA1IDA3OjQzOjIwDQpjb21taXR0ZXIgSmFtZXMgUHVyc2VyIDxwdXJzZXJqQGstc2l0LmNvbT4g
V2VkLCAxNSBKdW4gMjAwNSAwNzo0MzoyMA0KDQogZ2l0IHwgICA1OCArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQogMSBmaWxlcyBjaGFu
Z2VkLCA1NSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZ2l0
IGIvZ2l0DQotLS0gYS9naXQNCisrKyBiL2dpdA0KQEAgLTEsNCArMSw1NiBAQA0KICMhL2Jpbi9z
aA0KLWNtZD0iZ2l0LSQxLXNjcmlwdCINCi1zaGlmdA0KLWV4ZWMgJGNtZCAiJEAiDQorDQorY2Fz
ZSAiJDEiIGluDQorLWh8IiIpDQorCWVjaG8gIlVzZWFnZTogZ2l0IDxzdWJjb21tYW5kPiBbPHBh
cmFtIDE+LCA8cGFyYW0gMj4gLi4uXSINCisJZWNobyAiQXZhaWxhYmxlIGNvbW1hbmRzIGFyZToN
CisNCitnaXQgYXBwbHktcGF0Y2ggPHBhdGNoIGZpbGU+DQorDQorCUFwcGxpZXMgcGF0Y2ggZmls
ZSB0byBsb2NhbCBmaWxlcw0KKwkNCitnaXQgY29tbWl0IDxmaWxlIDE+IDxmaWxlIDI+IC4uLg0K
Kw0KKwlDb21taXRzIGxvY2FsIGNoYW5nZXMgdG8gdGhlIGNhY2hlLiBCZWZvcmUgcnVubmluZyB0
aGlzIHNjcmlwdCB5b3Ugd2lsbCBuZWVkIHRvIHJ1biBnaXQtdXBkYXRlLWNhY2hlIG9uIHRoZSBm
aWxlcyB5b3Ugd2lzaCB0byBjb21taXQuDQorDQorCVdpbGwgYWNjZXB0IHdpbGRjYXJkcyBpZSBn
aXQgY29tbWl0IGdpdC0qLXNjcmlwdHMNCisNCitnaXQgY3ZzaW1wb3J0IFstdl0gWy16IGZ1enpd
IDxjdnNyb290PiA8bW9kdWxlPg0KKwkNCisJQ1ZTIHRvIEdpdCBpbXBvcnQgdG9vbC4gUmVsaWVz
IG9uIHRoZSBjdnNwcyBwYWNrYWdlIGF0IGxlYXN0IDIuMQ0KKwkNCisJLXYgVmVyYm9zZSBvdXRw
dXQNCisJLXogDQorCTxjdnNyb290PiBQYXRoIHRvIENWUyBSZXBvc2l0b3J5DQorCTxtb2R1bGU+
IE1vZHVsZSB5b3Ugd2FudCB0byBpbXBvcnQgaW50byBnaXQNCisNCitnaXQgZGVsdGFmeToNCisN
CitnaXQgZGlmZiBbPEZpbGUgMT4sIDxGaWxlIDI+LCAuLi5dDQorDQorCURpZmZzIGJldHdlZW4g
dGhlIGdpdCBjYWNoZSBhbmQgc3BlY2lmaWVkIGZpbGVzLiBJZiBubyBmaWxlcyBhcmUgc3BlY2lm
aWVkIHRoZW4gY3JlYXRlcyBhIERpZmYgYmV0d2VlbiBjb250ZW50cyBvZiB0aGUgY2FjaGUgYW5k
IGFsbCBjdXJyZW50IGZpbGVzLg0KKw0KK2dpdCBmZXRjaDoNCisNCitnaXQgbG9nOg0KKw0KK2dp
dCBtZXJnZS1vbmUtZmlsZToNCisNCitnaXQgcHJ1bmU6DQorDQorZ2l0IHB1bGw6DQorDQorZ2l0
IHN0YXR1czoNCisNCitnaXQgdGFnOg0KKyINCisJZXhpdCAwIDs7DQorZXNhYw0KKw0KK2NtZD0i
Z2l0LSQxLXNjcmlwdCI7DQorc2hpZnQ7DQorZXhlYyAkY21kICIkQCI7DQorZ2l0IC1oDQorZXhp
dCAxDQorDQorDQo=

--=-uNgNsQROX8OrkqKwaqWn--

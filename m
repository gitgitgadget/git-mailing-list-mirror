From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: [PATCH] allow git-bundle to create bottomless bundle
Date: Thu, 9 Aug 2007 08:32:50 -0400
Message-ID: <30e4a070708090532y4d5f8528q8458fb5d28c980eb@mail.gmail.com>
References: <fcaeb9bf0708070623p24f1cae2q2af959a89738c4e8@mail.gmail.com>
	 <20070808035946.GP9527@spearce.org>
	 <Pine.LNX.4.64.0708081012110.14781@racer.site>
	 <7vlkcl4zcw.fsf@assigned-by-dhcp.cox.net>
	 <7vps1xzic2.fsf_-_@assigned-by-dhcp.cox.net>
	 <46BA8065.6010005@gmail.com> <7v643pz4c9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_157898_967161.1186662770088"
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Mark Levedahl" <mdl123@verizon.net>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 14:33:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ7CT-0002Sf-9q
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 14:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933597AbXHIMcz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 08:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933882AbXHIMcy
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 08:32:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:60651 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933444AbXHIMcx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 08:32:53 -0400
Received: by ug-out-1314.google.com with SMTP id j3so327446ugf
        for <git@vger.kernel.org>; Thu, 09 Aug 2007 05:32:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=Ssq+0eGveLzhuAmpI/DuCUhVB8q6rLr6MtrmuZ/fYs+7gg0y4g5XWZpwx/ECDKGi3j5M0xqkxOpZ0q4AyhtDUnNDGLjZDAJ7a92G5vuLP0bELr+5/TB19ZmPrfIa6PT5yDcp7khN8TWUOSY9aMXBEkpMCmY1QETQY6BEvboXQ6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=d4AjaNYjBjxjhoM5yxmTOozztIOy8N6Dtu6PvSdVqnmdEKLnFWttpw0lCi8E9ccM53VVxhZc9dDdVcuMkD6wi/PmQqE6r+UJA0XHRqlqDT5UtyFCfu42zELRxFq6KPBcN3bzclFysobs/VEGQ136pviPB0SVb8AMkcupD+lxUFE=
Received: by 10.78.200.3 with SMTP id x3mr449884huf.1186662770126;
        Thu, 09 Aug 2007 05:32:50 -0700 (PDT)
Received: by 10.78.190.5 with HTTP; Thu, 9 Aug 2007 05:32:50 -0700 (PDT)
In-Reply-To: <7v643pz4c9.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55446>

------=_Part_157898_967161.1186662770088
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/9/07, Junio C Hamano <gitster@pobox.com> wrote:
> Mark Levedahl <mlevedahl@gmail.com> writes:
>
> > Junio C Hamano wrote:
>
> Actually, there is another bug nearby.
>
Curious... I did a long time ago get git-bundle.sh to write out the
format Dscho finally implemented working in Linux and Cygwin. With
your latest patch, both produce identical bundles for a number of
cases, but the timing is very curious:

*builtin*
git>time git-bundle create foo refs/tags/v1.0.3
Generating pack...
Done counting 12288 objects.
Deltifying 12288 objects...
 100% (12288/12288) done
Writing 12288 objects...
 100% (12288/12288) done
Total 12288 (delta 8435), reused 11542 (delta 7961)

real    0m41.953s
user    0m5.060s
sys     0m39.685s

*shell script*
git>time git-bundle2 create foo2 refs/tags/v1.0.3
Generating pack...
Done counting 12288 objects.
Deltifying 12288 objects...
 100% (12288/12288) done
Total 12288 (delta 8435), reused 11542 (delta 7961)
Created foo2

real    0m2.453s
user    0m1.842s
sys     0m1.190s
git>diff foo foo2
git>

Since when is shell 20 times faster than a builtin? Ok, those results
are on Cygwin. On Linux, I get  1.21 sec for the builtin vs 0.933 for
the shell script. Not as dramatic, but the script is still faster. So,
I think this qualifies as a bug. I'm attaching the script (for info
only, I'm not suggesting to replace the builtin), as I can't usefully
put it inline from gmail.

The timing difference seem to be in the rev walking (by eyeball,
packfile generation time is the same), so something the shell script
is doing to get the rev list is obviously more efficient than how the
builtin works for this case.

Mark

------=_Part_157898_967161.1186662770088
Content-Type: application/octet-stream; name=git-bundle2
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f557r904
Content-Disposition: attachment; filename="git-bundle2"

IyEvYmluL3NoCiMgQmFzaWMgaGFuZGxlciBmb3IgYnVuZGxlIGZpbGVzIHRvIGNvbm5lY3QgcmVw
b3NpdG9yaWVzIHZpYSBzbmVha2VybmV0LgojIEludm9jYXRpb24gbXVzdCBpbmNsdWRlIGFjdGlv
bi4KIyBUaGlzIGZ1bmN0aW9uIGNhbiBjcmVhdGUgYSBidW5kbGUgb3IgcHJvdmlkZSBpbmZvcm1h
dGlvbiBvbiBhbiBleGlzdGluZyBidW5kbGUKIyBzdXBwb3J0aW5nIGdpdC1mZXRjaCwgZ2l0LXB1
bGwsIGFuZCBnaXQtbHMtcmVtb3RlCgojIGJ1bmRsZSBmb3JtYXQgaXM6CiMgbGluZTEgLSB2ZXJz
aW9uCiMgLXNoYTEgY29tbWl0IG1zZyAgOiBwcmVyZXF1aXNpdGVzCiMgc2hhMSBuYW1lICAgICAg
ICAgOyByZWZzCiMgPGJsYW5rIGxpbmU+CiMgcGFjayBmaWxlCgpVU0FHRT0nZ2l0LWJ1bmRsZSAo
IGNyZWF0ZSA8YnVuZGxlPiBbPHJldi1saXN0LWFyZ3M+Li4uXSB8CiAgICAgICAgIHZlcmlmeSB8
IGxpc3QtaGVhZHMgfCB1bmJ1bmRsZSA8YnVuZGxlPiApJwoKU1VCRElSRUNUT1JZX09LPTEKLiBn
aXQtc2gtc2V0dXAKTEY9JwonCgp2ZXJpZnkoKSB7CiAgICAjIENoZWNrIGJ1bmRsZSB2ZXJzaW9u
CiAgICB0ZXN0ICIkdmVyc2lvbiIgPSAiIyB2MiBnaXQgYnVuZGxlIiB8fAogICAgICAgIGRpZSAi
JGJmaWxlIGlzIG5vdCBhIHYyIGdpdCBidW5kbGUiCgogICAgIyBkbyBmYXN0IGNoZWNrLCB0aGVu
IGlmIGFueSBwcmVyZXFzIGFyZSBtaXNzaW5nIHRoZW4gZ28gbGluZSBieSBsaW5lCiAgICAjIHRv
IGJlIHZlcmJvc2UgYWJvdXQgdGhlIGVycm9ycwogICAgdGVzdCAteiAiJHByZXJlcXMiICYmIHJl
dHVybiAwCiAgICBpZiBiYWQ9JChlY2hvICIkcHJlcmVxcyIgfCBjdXQgLWItNDAgfCBnaXQtcmV2
LWxpc3QgLS1zdGRpbiAtLW5vdCAtLWFsbCAyPiYxKSAmJgogICAgdGVzdCAteiAiJGJhZCIgOyB0
aGVuCiAgICAgICAgcmV0dXJuIDAKICAgIGVsc2UKICAgICAgICBlY2hvID4vZGV2L3N0ZGVyciAi
ZXJyb3I6ICRiZmlsZSByZXF1aXJlcyB0aGUgZm9sbG93aW5nIG1pc3NpbmcgY29tbWl0czoiCiAg
ICAgICAgZWNobyAiJHByZXJlcXMiIHwKICAgICAgICB3aGlsZSByZWFkIHNoYTEgY29tbWVudCA7
IGRvCiAgICAgICAgICAgIGlmICEgbWlzc2luZz0kKGdpdC1yZXYtbGlzdCAkc2hhMSAtLW5vdCAt
LWFsbCAyPiYxKSB8fCB0ZXN0IC1uICIkbWlzc2luZyIgOyB0aGVuCiAgICAgICAgICAgICAgICBl
Y2hvID4vZGV2L3N0ZGVyciAiJHNoYTEgJGNvbW1lbnQiCiAgICAgICAgICAgIGZpCiAgICAgICAg
ZG9uZQogICAgICAgIHJldHVybiAxCiAgICBmaQp9CgojIGxpc3QgYWxsIHJlZnMgb3IganVzdCBh
IHN1YnNldApsaXN0X2hlYWRzKCkgewogICAgaWYgdGVzdCAteiAiJCoiIDsgdGhlbgogICAgICAg
IGVjaG8gIiRyZWZzIgogICAgZWxzZQogICAgICAgIGVjaG8gIiRyZWZzIiB8CiAgICAgICAgd2hp
bGUgcmVhZCBzaGExIHJlZiA7IGRvCiAgICAgICAgICAgIGZvciBhcmcgaW4gJCogOyBkbwogICAg
ICAgICAgICAgICAgaWYgdGVzdCAiJHtyZWYlJGFyZ30iICE9ICIkcmVmIiA7IHRoZW4KICAgICAg
ICAgICAgICAgICAgICBlY2hvICIkc2hhMSAkcmVmIgogICAgICAgICAgICAgICAgICAgIGJyZWFr
CiAgICAgICAgICAgICAgICBmaQogICAgICAgICAgICBkb25lCiAgICAgICAgZG9uZQogICAgZmkK
fQoKIyBjcmVhdGUgYSBidW5kbGUKY3JlYXRlKCkgewogICAgdW5rbm93bj0kKGdpdC1yZXYtcGFy
c2UgLS1uby1yZXZzICRhcmdzKQogICAgdGVzdCAteiAiJHVua25vd24iIHx8IGRpZSAidW5rbm93
biBvcHRpb246ICR1bmtub3duIgogICAgZ2l0cmV2YXJncz0kKGdpdC1yZXYtcGFyc2UgLS1zeW1i
b2xpYyAtLXJldnMtb25seSAkYXJncykgfHwgZXhpdCAxCgogICAgIyBmaW5kIHRoZSByZWZzIHRv
IGNhcnJ5IGFsb25nIGFuZCBnZXQgc2hhMXMgZm9yIGVhY2guCiAgICByZWZzPQogICAgYm91bmRh
cnlhcmdzPQogICAgYmFzaXM9CiAgICBmb3IgYXJnIGluICRnaXRyZXZhcmdzIDsgZG8KICAgICAg
ICAjaWdub3JlIG9wdGlvbnMgYW5kIGJhc2lzIHJlZnMsIGdldCBmdWxsIHJlZiBuYW1lIGZvciB0
aGluZ3MKICAgICAgICAjIHdlIHdpbGwgdHJhbnNwb3J0IHJlamVjdGluZyBhbnl0aGluZyBhbWJp
Z3VvdXMgKGUuZy4sIHVzZXIKICAgICAgICAjIGdpdmVzIG1hc3RlciwgaGF2ZSBoZWFkcy9tYXN0
ZXIgYW5kIHJlbW90ZXMvb3JpZ2luL21hc3Rlciwgd2UKICAgICAgICAjIGtlZXAgdGhlIGZvcm1l
cikuCiAgICAgICAgY2FzZSAiJGFyZyIgaW4KICAgICAgICAgICAgXiopCiAgICAgICAgICAgICAg
ICBib3VuZGFyeWFyZ3M9IiRib3VuZGFyeWFyZ3MgJGFyZyIKICAgICAgICAgICAgICAgIGJhc2lz
PSIkYmFzaXMgJHthcmcvXi99Ijs7CiAgICAgICAgICAgIC0qKQogICAgICAgICAgICAgICAgYm91
bmRhcnlhcmdzPSIkYm91bmRhcnlhcmdzICRhcmciOzsKICAgICAgICAgICAgKikKICAgICAgICAg
ICAgICAgIHJlZnM9IiRyZWZzJExGJChnaXQgc2hvdy1yZWYgJGFyZyB8IGhlYWQgLW4xKSI7Owog
ICAgICAgIGVzYWMKICAgIGRvbmUKICAgIHRlc3QgLXogIiRyZWZzIiAmJiBkaWUgIk5vIHJlZmVy
ZW5jZXMgc3BlY2lmaWVkLCBJIGRvbid0IGtub3cgd2hhdCB0byBidW5kbGUuIgoJc2hhMXJlZnM9
JChlY2hvICIkcmVmcyIgfCBjdXQgLWItNDApCgogICAgIyBnZXQgcHJlcmVxdWlzaXRlIGNvbW1p
dHMgdGhpcyBidW5kbGUgZGVwZW5kcyB1cG9uCiAgICBwcmVyZXFzPSQoZ2l0LXJldi1saXN0IC0t
Ym91bmRhcnkgJGJvdW5kYXJ5YXJncyAkc2hhMXJlZnMgfCBzZWQgLW5lICdzL14tLy9wJykKICAg
IGlmIHRlc3QgLW4gIiRiYXNpcyIgOyB0aGVuCiAgICAgICAgcHJlcmVxcz0kKHByaW50ZiAiJXNc
biIgJHByZXJlcXMgJChnaXQtcmV2LXBhcnNlICRiYXNpcykgfCBzb3J0IHwgdW5pcSkKICAgIGZp
CgkKICAgICMgY3JlYXRlIHJlZnMgYW5kIHBhY2suIFdlIGRvIHRoaXMgaW4gYSBzdWJzaGVsbCB0
byBhdm9pZCB1c2luZyA+PiB0byBhcHBlbmQsCiAgICAjIGFzIHRoYXQgaW5kdWNlcyBjcmxmIGJy
ZWFrYWdlIHVuZGVyIEN5Z3dpbi4KICAgICgKICAgICAgICBlY2hvICIjIHYyIGdpdCBidW5kbGUi
ICYmCiAgICAgICAgKGZvciBwIGluICRwcmVyZXFzIDsgZG8KICAgICAgICAgICAgcHJpbnRmICIl
c1xuIiAiLSQoZ2l0LXJldi1saXN0IC0tcHJldHR5PW9uZSAtLW1heC1jb3VudD0xICRwKSIKICAg
ICAgICBkb25lKSAmJgogICAgICAgIGdpdC1zaG93LXJlZiAkcmVmcyAmJgogICAgICAgIGVjaG8g
IiIgJiYKICAgICAgICAocHJpbnRmICIlc1xuIiAkc2hhMXJlZnMgJiYKICAgICAgICB0ZXN0IC1u
ICIkcHJlcmVxcyIgJiYgcHJpbnRmICJeJXNcbiIgJHByZXJlcXMgKSB8CiAgICAgICAgZ2l0IHBh
Y2stb2JqZWN0cyAtLXRoaW4gLS1zdGRvdXQgLS1wcm9ncmVzcwogICAgKSA+ICIkYmZpbGUiCiAg
ICBpZiB0ZXN0ICQ/IC1ndCAwOyB0aGVuCiAgICAgICAgcm0gLWZ2ICIkYmZpbGUiCiAgICBlbHNl
CiAgICAgICAgZWNobyAiQ3JlYXRlZCAkYmZpbGUiCiAgICBmaQp9CgojIHBhcnNlIGlucHV0cywg
ZGVjaWRlIHdoYXQgdG8gZG8KYXJncz0KYWN0aW9uPQp3aGlsZSB0ZXN0IC1uICIkMSIgOyBkbwog
ICAgY2FzZSAkMSBpbgogICAgICAgIGNyZWF0ZXxsaXN0LWhlYWRzfHVuYnVuZGxlfHZlcmlmeXxz
aG93KQogICAgICAgICAgICBhY3Rpb249JDEKICAgICAgICAgICAgc2hpZnQKICAgICAgICAgICAg
YmZpbGU9JDEKICAgICAgICAgICAgdGVzdCAteiAiJGJmaWxlIiAmJiBkaWUgIiRhY3Rpb24gcmVx
dWlyZXMgZmlsZW5hbWUiOzsKICAgICAgICAqKQogICAgICAgICAgICBhcmdzPSIkYXJncyAkMSI7
OwogICAgZXNhYwogICAgc2hpZnQKZG9uZQp0ZXN0IC16ICIkYWN0aW9uIiAmJiBkaWUgIk5vIGFj
dGlvbiBnaXZlbiwgd2hhdCBzaG91bGQgSSBkbz8iCgppZiB0ZXN0ICIkYWN0aW9uIiA9ICJjcmVh
dGUiIDsgdGhlbgogICAgY3JlYXRlCmVsc2UKICAgIHRlc3QgLWYgIiRiZmlsZSIgfHwgZGllICJD
b3VsZCBub3QgZmluZCAkYmZpbGUiCgogICAgIyBnZXQgdGhlIGhlYWRlciBvbmNlLCB2ZXJpZnkg
YWxsIGlzIG9rCiAgICBoZWFkZXI9JChzZWQgLWUgJy9eJC8sJGQnICIkYmZpbGUiKQogICAgcmVm
cz0kKGVjaG8gIiRoZWFkZXIiIHwgc2VkIC1lICcxZDsvXi0vZCcpCiAgICBwcmVyZXFzPSQoZWNo
byAiJGhlYWRlciIgfCBzZWQgLW5lICdzL14tLy9wJykKICAgIHZlcnNpb249JChlY2hvICIkaGVh
ZGVyIiB8IGhlYWQgLW4xKQoKICAgIGVjaG8gJHZlcnNpb24KCiAgICBjYXNlICRhY3Rpb24gaW4K
ICAgICAgICB2ZXJpZnkpCiAgICAgICAgICAgIHZlcmlmeSAmJiBlY2hvICIkYmZpbGUgaXMgb2si
OzsKCiAgICAgICAgbGlzdC1oZWFkcykKICAgICAgICAgICAgbGlzdF9oZWFkcyAkYXJnczs7Cgog
ICAgICAgIHNob3cpCiAgICAgICAgICAgIGVjaG8gIiRoZWFkZXIiIHwgc2VkIC1uZSAiL14tL3Ai
CiAgICAgICAgICAgIGVjaG8gIiRyZWZzIjs7CgogICAgICAgIHVuYnVuZGxlKQogICAgICAgICAg
ICB2ZXJpZnkgfHwgZXhpdCAxCiAgICAgICAgICAgIHNlZCAtYmUgJzEsL14kL2QnICIkYmZpbGUi
IHwgZ2l0LWluZGV4LXBhY2sgLS1zdGRpbiAtLWZpeC10aGluIHx8CiAgICAgICAgICAgICAgICBk
aWUgImVycm9yOiAkYmZpbGUgaGFzIGEgY29ycnVwdGVkIHBhY2sgZmlsZSIKICAgICAgICAgICAg
bGlzdF9oZWFkcyAkYXJnczs7CiAgICBlc2FjCmZpCg==
------=_Part_157898_967161.1186662770088--

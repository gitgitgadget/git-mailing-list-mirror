From: Dan Zwell <dzwell@zwell.net>
Subject: Re: [PATCH] Limit git-gui to display a maximum number of files
Date: Tue, 11 Aug 2009 13:23:52 -0500
Message-ID: <4A81B738.7090507@zwell.net>
References: <4A4A77A6.1020905@lawrence.edu> <20090810153859.GT1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, raa.lkml@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 11 22:24:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaxtR-0003L2-F1
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 22:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbZHKUYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 16:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbZHKUYI
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 16:24:08 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:58571 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbZHKUYH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 16:24:07 -0400
Received: by wa-out-1112.google.com with SMTP id j5so974418wah.21
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 13:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=kta5oHwdS2PwPwVFETO7YaMZjIKstt7lyO6ovsf+YsI=;
        b=k7GhUgxlYK5N5EF38n52PxAqWQ0xkW3Q18LIAnaFArKg11gO3lY/lo+MIZvr2SS7j9
         BPsW+aNT2VkFkXYW7TPaT7Mr/r4mmKazPPKSRLk6tnOY4QzfuJPMdjp+dOoHnP+24IOK
         pmKsqIAUqaUGaiLgegwhWqkh4oziL9FVyyLMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=UVR+uj82L8zaxErMV2axMavTn327CFu8+aVQpvU2Rds5I17yCJD6Pm5NPLKmfj0ffA
         tlPuFM5LFxLe320gWNIvJr0av7KAk+Y121/3zlc1KW4BZO/0fvOyM91rKNYG4JN5HOTR
         W5XrKMTV1ybPqYM3w2FX1nnu+KF4aJX8GgmTo=
Received: by 10.114.191.2 with SMTP id o2mr8692543waf.125.1250022248511;
        Tue, 11 Aug 2009 13:24:08 -0700 (PDT)
Received: from ?192.168.1.105? (c-76-21-120-57.hsd1.ca.comcast.net [76.21.120.57])
        by mx.google.com with ESMTPS id m28sm11215737waf.2.2009.08.11.13.24.06
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 13:24:07 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090719)
In-Reply-To: <20090810153859.GT1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125589>

When there is a large number of new or modified files,
"display_all_files" takes a long time, and git-gui appears to
hang. This change limits the number of files that are displayed.
This limit can be set as gui.maxfilesdisplayed, and is
5000 by default.

A warning is shown when the list of files is truncated.

Signed-off-by: Dan Zwell <dzwell@zwell.net>
---
By the way, is the right way to deal with strings to be
translated? See the end of the patch.

 git-gui.sh     |   18 +++++++++++++++++-
 po/git-gui.pot |    5 +++++
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 3c0ce26..a4dde9e 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -745,6 +745,8 @@ set default_config(gui.newbranchtemplate) {}
 set default_config(gui.spellingdictionary) {}
 set default_config(gui.fontui) [font configure font_ui]
 set default_config(gui.fontdiff) [font configure font_diff]
+# TODO: this option should be added to the git-config documentation
+set default_config(gui.maxfilesdisplayed) 5000
 set font_descs {
 	{fontui   font_ui   {mc "Main Font"}}
 	{fontdiff font_diff {mc "Diff/Console Font"}}
@@ -1698,10 +1700,12 @@ proc display_all_files_helper {w path icon_name m} {
 	$w insert end "[escape_path $path]\n"
 }
 
+set files_warning 0
 proc display_all_files {} {
 	global ui_index ui_workdir
 	global file_states file_lists
 	global last_clicked
+	global files_warning
 
 	$ui_index conf -state normal
 	$ui_workdir conf -state normal
@@ -1713,7 +1717,19 @@ proc display_all_files {} {
 	set file_lists($ui_index) [list]
 	set file_lists($ui_workdir) [list]
 
-	foreach path [lsort [array names file_states]] {
+	set to_display [lsort [array names file_states]]
+	set display_limit [get_config gui.maxfilesdisplayed]
+	if {[llength $to_display] > $display_limit} {
+		if {!$files_warning} {
+			# do not repeatedly warn:
+			set files_warning 1
+			set warning "Displaying only $display_limit of "
+			append warning "[llength $to_display] files."
+			info_popup [mc $warning]
+		}
+		set to_display [lrange $to_display 0 [expr {$display_limit-1}]]
+	}
+	foreach path $to_display {
 		set s $file_states($path)
 		set m [lindex $s 0]
 		set icon_name [lindex $s 1]
diff --git a/po/git-gui.pot b/po/git-gui.pot
index 53b7d36..fb60472 100644
--- a/po/git-gui.pot
+++ b/po/git-gui.pot
@@ -90,6 +90,11 @@ msgstr ""
 msgid "Ready."
 msgstr ""
 
+#: git-gui.sh:1725
+#, tcl-format
+msgid "Displaying only %s of %s files."
+msgstr ""
+
 #: git-gui.sh:1819
 msgid "Unmodified"
 msgstr ""
-- 
1.6.4


Shawn O. Pearce wrote:

> Dan Zwell <dzwell@gmail.com> wrote:
>   
>> When there is a large number of new or modified files,
>> "display_all_files" takes a long time, and git-gui appears to
>> hang. Limit the display to 5000 files, by default. This number
>> is configurable as gui.maxfilesdisplayed.
>>
>> Show a warning if the list of files is truncated.
>>     
>
>   
>> @@ -1713,7 +1717,18 @@ proc display_all_files {} {
>> 	set file_lists($ui_index) [list]
>> 	set file_lists($ui_workdir) [list]
>>
>> -	foreach path [lsort [array names file_states]] {
>> +	set to_display [lsort [array names file_states]]
>> +	set display_limit $default_config(gui.maxfilesdisplayed)
>>     
>
> This should use [get_config gui.maxfilesdisplayed] so that the
> user can actually set this property in a configuration file and
> have git-gui honor it.  Reading from $default_config means you are
> only looking at the hardcoded value you set in git-gui.sh.
>
>   
>> +	if {[llength $to_display] > $display_limit} {
>> +		if {![info exists files_warning] || !$files_warning} {
>>     
>
> Wouldn't it be easier to just set files_warning to 0 at the start
> of the script, so that you don't need to do this info exists test?
>
>   
>> +			set warning "Displaying only $display_limit of "
>> +			append warning "[llength $to_display] files."
>> +			info_popup [mc $warning]
>>     
>
> This needs to be in the translated strings.
>
>   

From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Documentation/config.txt: Document config file syntax better
Date: Mon, 22 Jan 2007 16:25:47 +0100
Message-ID: <11694795473648-git-send-email-jnareb@gmail.com>
References: <11693017892595-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 22 16:25:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H912u-0005uR-Eg
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 16:25:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbXAVPZR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 10:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbXAVPZQ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 10:25:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:49728 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbXAVPZO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 10:25:14 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1079099uga
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 07:25:12 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hZmwWsw0h8BTz9P4rvLm9O/GpaH9U5W2EsNOC5sHvSa7uFCLf5k238ALjxfi7RKapMedT2gwUsbBTndKgXS74cQuLII1qmSipJuGmgLNnlxANVu8eJsd5FmJaUspHceOok6ZL3NJ8WjH6+sV9JC57XzoS+ETtQL+idV6xGNjMLg=
Received: by 10.67.22.2 with SMTP id z2mr7790456ugi.1169479512466;
        Mon, 22 Jan 2007 07:25:12 -0800 (PST)
Received: from roke.D-201 ( [81.190.20.200])
        by mx.google.com with ESMTP id 54sm7044967ugp.2007.01.22.07.25.11;
        Mon, 22 Jan 2007 07:25:11 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l0MFPrW7023348;
	Mon, 22 Jan 2007 16:25:54 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l0MFPlK3023338;
	Mon, 22 Jan 2007 16:25:47 +0100
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.4
In-Reply-To: <11693017892595-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37417>

Separate part of Documentation/config.txt which deals with git config file
syntax into "Syntax" subsection, and expand it.  Add information about
subsections, boolean values, escaping and escape sequences in string
values, and continuing variable value on the next line.

Add also proxy settings to config file example to show example of
partially enclosed in double quotes string value.

Parts based on comments by Junio C Hamano, Johannes Schindelin,
config.c, and the smb.conf(5) man page.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
>  
>> What about my Documentation/config.txt changes?
> 
> I was not sure about that one, given a lot of commentary in your
> message, suggesting more research and revision is needed, like
> these...
> 
>>>> +All the other lines are recognized as setting variables, in the form
>>>> +'name = value'. If there is no equal sign on the line, the entire line
>>>> +is taken as 'name' and the variable is recognized as boolean "true".
>>>> +Variable names are case insensitive.
>>> 
>>> They cannot contain anything else than alphanumeric characters, in 
>>> particular no whitespace.
>>
>> It is mentioned above "Syntax" section, but perhaps it should be repeated.
>> I haven't took a look at code to check what values for section names and
>> for key/variable names are allowed.
>> ...
>>> One thing that left me puzzled after reading the description was
>>> what a user can do with "subsection".  It is unclear from the
>>> description if [section "sub.section"], [section "sub.sec=ti.on"]
>>> or worse yet, [section "sub\nsection with an embbedded LF"] are
>>> allowed.  The rest seemed sane.
>>
>> I'm not sure what is allowed in section name, and in subsection name,
>> so for now I have left it as is. I can amend this commit, or add new
>> commit explaining this.

I hope that this is satisfactory.


I haven't wrote about current limits on the lengths: 256/2 for section
plus subsection name length, 256 for fully qualified variable name,
1024 for value length; I think this does not belong to end user
documentation.

 Documentation/config.txt |   76 +++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f1f409d..77a2b16 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -14,14 +14,72 @@ dot-separated segment and the section name is everything before the last
 dot. The variable names are case-insensitive and only alphanumeric
 characters are allowed. Some variables may appear multiple times.
 
+Syntax
+~~~~~~
+
 The syntax is fairly flexible and permissive; whitespaces are mostly
-ignored. The '#' and ';' characters begin comments to the end of line,
-blank lines are ignored, lines containing strings enclosed in square
-brackets start sections and all the other lines are recognized
-as setting variables, in the form 'name = value'. If there is no equal
-sign on the line, the entire line is taken as 'name' and the variable
-is recognized as boolean "true". String values may be entirely or partially
-enclosed in double quotes; some variables may require special value format.
+ignored.  The '#' and ';' characters begin comments to the end of line,
+blank lines are ignored.
+
+The file consists of sections and variables.  A section begins with
+the name of the section in square brackets and continues until the next
+section begins.  Section names are not case sensitive.  Only alphanumeric
+characters, '`-`' and '`.`' are allowed in section names.  Each variable
+must belong to some section, which means that there must be section
+header before first setting of a variable.
+
+Sections can be further divided into subsections.  To begin a subsection
+put its name in double quotes, separated by space from the section name,
+in the section header, like in example below:
+
+--------
+	[section "subsection"]
+
+--------
+
+Subsection names can contain any characters (doublequote '`"`', backslash
+'`\`' and newline have to be entered escaped as '`\"`', '`\\`' and '`\n`',
+respecitvely) and are case sensitive.  Section header cannot span multiple
+lines.  Variables may belong directly to a section or to a given subsection.
+You can have `[section]` if you have `[section "subsection"]`, but you
+don't need to.
+
+There is also (case insensitive) alternative `[section.subsection]` syntax.
+In this syntax subsection names follow the same restrictions as for section
+name.
+
+All the other lines are recognized as setting variables, in the form
+'name = value'.  If there is no equal sign on the line, the entire line
+is taken as 'name' and the variable is recognized as boolean "true".
+The variable names are case-insensitive and only alphanumeric
+characters and '`-`' are allowed.  There can be more than one value
+for a given variable; we say then that variable is multivalued.
+
+Leading and trailing whitespace in a variable value is discarded.
+Internal whitespace within a variable value is retained verbatim.
+
+The values following the equals sign in variable assign are all either
+a string, an integer, or a boolean.  Boolean values may be given as yes/no,
+0/1 or true/false.  Case is not significant in boolean values, when
+converting value to the canonical form using '--bool' type specifier;
+`git-repo-config` will ensure that the output is "true" or "false".
+
+String values may be entirely or partially enclosed in double quotes.
+You need to enclose variable value in double quotes if you want to
+preserve leading or trailing whitespace, or if variable value contains
+beginning of comment characters (if it contains '#' or ';').
+Double quote '`"`' and backslash '`\`' characters in variable value must
+be escaped: use '`\"`' for '`"`' and '`\\`' for '`\`'.
+
+The following escape sequences (beside '`\"`' and '`\\`') are recognized:
+'`\n`' for newline character (NL), '`\t`' for horizontal tabulation (HT, TAB)
+and '`\b`' for backspace (BS).  No other char escape sequence, nor octal
+char sequences are valid.
+
+Variable value ending in a '`\`' is continued on the next line in the
+customary UNIX fashion.
+
+Some variables may require special value format.
 
 Example
 ~~~~~~~
@@ -40,6 +98,10 @@ Example
 		remote = origin
 		merge = refs/heads/devel
 
+	# Proxy settings
+	[core]
+		gitProxy="ssh" for "ssh://kernel.org/"
+		gitProxy=default-proxy ; for the rest
 
 Variables
 ~~~~~~~~~
-- 
1.4.4.4

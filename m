From: =?UTF-8?B?0JDQvdC00YDQtdC5INCR0LDRgNCw0L3QvtCy?= 
	<admin@andrej-andb.ru>
Subject: Fwd: Separately repository access in GitWeb
Date: Fri, 25 Jan 2013 16:00:40 +0700
Message-ID: <CAJjU7bQ65q_oznTV57oMM4XPkHrEUwZ-TZ4UzRHp=k7VkfMDGg@mail.gmail.com>
References: <CAJjU7bS-rRr-UuEA_xcqtTY4+tWKshL+Rvey85n70KacSnTorQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 25 10:01:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyf9y-0007IF-Gs
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 10:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900Ab3AYJAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 04:00:53 -0500
Received: from mail-oa0-f54.google.com ([209.85.219.54]:49664 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088Ab3AYJAl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 04:00:41 -0500
Received: by mail-oa0-f54.google.com with SMTP id n9so118636oag.27
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 01:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrej-andb.ru; s=google;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=CFuxo2Durxjq43THh8X3C1HeGNvweoiZmizCUJXOocE=;
        b=HnrqsfDZ6uXg/2+qUSLKo3PP+FlVrshondiA9+z2fHZ0WvDTLloNu3OpmL7zbDQySg
         0oDhEKDGel/E2X20wJqU/6zPbahWvCh4VfRZynKICfDDoRWWB3AihJWXDTFE4dNVXEOU
         VqFzEaRI4rdQe+nIyEII4HZsD8TJcpVe7puLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:content-type:x-gm-message-state;
        bh=CFuxo2Durxjq43THh8X3C1HeGNvweoiZmizCUJXOocE=;
        b=RXJkbCmOU7MkLWdtGifHOWmXvnXPxPo5rHoVzcj626gBvo9FdAvsOJvChx8H2gqaNG
         FDYj6Y4+aUBR9vhxnpqB/ikZR8v5fE44Pl1y9kIIu1jXH76HkxiPLwyauEmEIU2MUofU
         kKOa3ZSFKvmr7iGZjClk2BvDH5Y8xZ4UQZ9V6NdTDS9b+KCOKzyGBaOTeTmvlwqvPxoT
         R5yhvD/X/kfuRD4fBqEucwKcsswc6ucMJBHA9yKHkO+xwe7L/mBprZqitlUQ0Jt5351a
         6ctgoZgoOHgPR114WaH5UaJJyKgzvc9ciOep+C3w+73j15V9UEkR1WXTqYzACwXe/aH6
         dz+Q==
X-Received: by 10.60.3.193 with SMTP id e1mr4056229oee.39.1359104441087; Fri,
 25 Jan 2013 01:00:41 -0800 (PST)
Received: by 10.76.9.35 with HTTP; Fri, 25 Jan 2013 01:00:40 -0800 (PST)
X-Originating-IP: [90.188.9.189]
In-Reply-To: <CAJjU7bS-rRr-UuEA_xcqtTY4+tWKshL+Rvey85n70KacSnTorQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQmwmdCXneOV+tTHudv/SXxijH9abeMTUAszk1bgZrAU3AJglqaOaUWwWD6RBE4VUGJopqW9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214518>

good day.

I`m trying make separately repository access in GitWeb by NGINX

separation of access based on URL strings, namely, the presence of the
query strings:
'?p=repo.git'
with a regular expression:
"^.*p=(.*?)(\.git|;|&|=|\s).*$"

I am wondering how much it is correct to protect against unauthorized access.

Thanks in advance :)

complete example of a configuration file:

server {
        listen 80;

root /home/git/gitweb;

        access_log /var/log/nginx/gitweb.access_log main;
        error_log /var/log/nginx/gitweb.error_log info;

        index gitweb.cgi;
gzip off;

    location ~* \.(jpg|txt|jpeg|gif|png|ico|css|zip|js|swf)$ {
access_log        off;
        expires 1d;
    }

    location = / {
set $htpasswd "opened@";
if ($args ~* "^.*p=(.*?)(\.git|;|&|=|\s).*$") {
set $htpasswd /home/git/.gitolite/conf/$1_htpasswd;
        }
        if (-f $htpasswd) {
                rewrite ^.*$  /closed last;
        }

rewrite ^.*$ /guest last;
    }

    location = /closed {
internal;
access_log /var/log/nginx/gitweb-closed.access_log main;
auth_basic "Unauthorized";
        auth_basic_user_file $htpasswd;
        include fastcgi_params;
        fastcgi_param  SCRIPT_NAME gitweb.cgi;
        fastcgi_param SCRIPT_FILENAME /home/git/gitweb/gitweb.cgi;
        fastcgi_pass unix:/var/run/fcgiwrap.socket;
    }

    location = /guest {
internal;
access_log /var/log/nginx/gitweb-guest.access_log main;
        include fastcgi_params;
fastcgi_param  SCRIPT_NAME gitweb.cgi;
fastcgi_param SCRIPT_FILENAME /home/git/gitweb/gitweb.cgi;
        fastcgi_pass unix:/var/run/fcgiwrap.socket;
    }

    location  / {
        rewrite (.*) / permanent;
    }

}

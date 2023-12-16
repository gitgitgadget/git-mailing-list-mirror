Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE591E492
	for <git@vger.kernel.org>; Sat, 16 Dec 2023 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T299kE9P"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-db3a09e96daso1101999276.3
        for <git@vger.kernel.org>; Sat, 16 Dec 2023 07:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702741586; x=1703346386; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PijZhrw/tIaXQcBzEtGOvMOD296d8oqX3AoHSGBToCg=;
        b=T299kE9PLLpyxnZ/PbqDFe7IFFGowfA/hqpc2q4YNLiPaqRutTqUfeqZn+AS5v3fht
         CdfxW1kQ+hZCgFR911i7yGJP4a400hV8q6lH9Rm5fu3xYbxvnZJZR7gXgQbHEdqreFhs
         bVbntFODib/VjC+NSZlpTjbrUmI16w/AseSujLOI9WJVlJ311w0DJOlRdkizpwFC4ud2
         Qw1buMtCXpoTY4x7tml5YB/WrqQIyuV5fDNt+7i0Rrg4e0rKkKkbHBbPvHjoJASVdRHt
         2+U6EWi6X0L8UvSuDdt53LNfy4JZ5Qkb911MIETxpywrP+UdWEWXfc0Xb2qT4i3oCeJp
         kHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702741586; x=1703346386;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PijZhrw/tIaXQcBzEtGOvMOD296d8oqX3AoHSGBToCg=;
        b=WJkRAunX5BoTOlOszsYlj7FkNTQ9bfng8g1J9NKpN5ENAbh6+yn/xeITMFtw+Y4SeY
         XoRxlRJFNlTZq/ONrOFvQk4id6WZKBxxsRFRZfeSMXrMw7uY+iZhocXCKhIOv/K7xFtn
         oryo7TFbIgVqcFNUbmxbht/EdDHdnhjmwwY8vfwiJPJxb8PzCFbRX4vkYk5JxLuYUlWk
         +9GkvgW3JJIngWCQrzD2iOgoSp0uHRc9xo9ujBZ9cTp1P7ba5yCCf93YJw9uwhaYXfB8
         n4brcy3Vsq4eZc6Mx/eE1flhsvAD4v65NIBiEwQzN4iZyWDk1PnZopTJZqYuaZPe8KNc
         BHtQ==
X-Gm-Message-State: AOJu0YzAMvVhy8wBgwZObvfHiE0/1A0ucxOWpt00BUDJQd5lM9MFKEyS
	dvKUMtUH5xtUk9YRxjvLfzcnKwcA4i0mV7DfdRfbQQBxhQE=
X-Google-Smtp-Source: AGHT+IHVzsmY/v1ae2+r+vmuexAiwRUBIPkEzNhRRYYynU6XoDPysnaOiQf3JANNFZ/nxdbDUPASurmEESPc52fsTc4=
X-Received: by 2002:a25:89:0:b0:dbd:f01:7b95 with SMTP id 131-20020a250089000000b00dbd0f017b95mr170724yba.94.1702741586115;
 Sat, 16 Dec 2023 07:46:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mohamed Mohey <mmi9433@gmail.com>
Date: Sat, 16 Dec 2023 17:46:15 +0200
Message-ID: <CAAY9aimx4X2jDaFz+jWtAj==g+J3QA8LKPQFePyGFhVvbwKNtQ@mail.gmail.com>
Subject: Question: rerere preimage format
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I was reading the Rerere section of the Pro Git book when I came
across the following snippet:

$ git rerere diff
--- a/hello.rb
+++ b/hello.rb
@@ -1,11 +1,11 @@
 #! /usr/bin/env ruby
 def hello
-<<<<<<<
-  puts 'hello mundo'
-=======
+<<<<<<< HEAD
   puts 'hola world'
->>>>>>>
+=======
+  puts 'hello mundo'
+>>>>>>> i18n-world
 end

If I understand correctly, this is the diff between rerere's preimage
and the version in the current working directory, as explained in this
StackOverflow answer:

https://stackoverflow.com/a/27364585


What I don't understand, however, is why rerere records its initial
preimage without labels. This seems to have been rerere's behavior
ever since it was introduced as a perl script back in 2006:

https://lore.kernel.org/git/7v4q3no0v7.fsf@assigned-by-dhcp.cox.net/

+ $one = join('', @{$side[0]});
+ $two = join('', @{$side[1]});
+ if ($two le $one) {
+ ($one, $two) = ($two, $one);
+ }
+ print $out "<<<<<<<\n";
+ print $out $one;
+ print $out "=======\n";
+ print $out $two;
+ print $out ">>>>>>>\n";
+ @side = ();


So the preimage format doesn't contain any labels, and outputs the
lexicographically smaller hunk first,
while the default merge conflict output has labels and outputs the
current branch first followed by the other branch.

If rerere recorded its preimage in the same format as the default
merge conflict format,
the above rerere diff output would be empty as there would be no
difference between what we started with and what we resolved into.

The same behaviour would still occur with the diff3 style format, for
example, but at least it wouldn't occur with the default merge style
format.

My question is:

Is there a reason rerere's output is like this that I'm missing? Or is
it just there for convenience since it doesn't affect rerere's
intended functionality?


Thanks,
Mohamed Mohey
